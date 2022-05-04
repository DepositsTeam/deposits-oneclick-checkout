import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';


class PaymentsController extends GetxController {
  int choice = 0;
  int bankChoice = -1;
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  var isAddBank = false.obs;
  RxList<Cards> allCards = <Cards>[].obs;
  RxList<BankAccount> allBankAccounts = <BankAccount>[].obs;
  var isPayWithCard = true.obs;

  updateChoice(
    int value,
  ) {
    Storage.removeValue(Constants.cardNumber);
    Storage.removeValue(Constants.cardId);
    choice = value;
    Cards selectedCard = allCards[value];
    Storage.saveValue(
        Constants.cardNumber, selectedCard.metaDataJson!.maskedCardNumber);
    Storage.saveValue(Constants.cardId, selectedCard.id);
    isPayWithCard(true);
    //handle bank selection
    bankChoice = -1;
    Storage.removeValue(Constants.accountNumber);
    Storage.removeValue(Constants.bankId);
    //print( " thse option is ${selectedCard.id} and ${selectedCard.metaDataJson!.maskedCardNumber}");
    update();
  }

  updateBankChoice(
    int value,
  ) {
    Storage.removeValue(Constants.accountNumber);
    Storage.removeValue(Constants.bankId);
    bankChoice = value;
    BankAccount selectedBank = allBankAccounts[value];
    Storage.saveValue(
        Constants.accountNumber,
        selectedBank.accountNumber!
            .substring(selectedBank.accountNumber!.length - 6));
    Storage.saveValue(Constants.bankId, selectedBank.id);
    isPayWithCard(false);
    //handle cards selection
    choice = -1;
    Storage.removeValue(Constants.cardNumber);
    Storage.removeValue(Constants.cardId);
    // print(" thse option is ${selectedBank.id} and ${selectedBank.accountNumber}");
    update();
  }

  // @override
  // void onInit() {
  //   fetchfundingSources();
  //   super.onInit();
  // }

  void fetchfundingSources(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };
      var response = await DioClient().request(
         context: context, api: '/get-funding-sources', method: Method.POST, params: request);
       
      GetFundingResponse getFundingResponse =
          GetFundingResponse.fromJson(response);
      if (getFundingResponse.status == Strings.success) {
        allCards = getFundingResponse.data!.cards!.obs;
        allBankAccounts = getFundingResponse.data!.bankAccounts!.obs;
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        return Utils.showSnackbar(
            context, Strings.error, response['message'], AppColors.red);
      }
    } finally {
      isLoading(false);
    }
    update();
  }

  void addNewCard(BuildContext context) {
    Utils.navigationPush(
        context,
       const AddNewCard());
  }

  void addNewBank(BuildContext context) async {
    try {
      isAddBank(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };
      var response = await DioClient().request(context: context,
          api: '/get-add-bank-url', method: Method.POST, params: request);

      AddBankResponse addBankResponse = AddBankResponse.fromJson(response);
      if (addBankResponse.status == Strings.success) {
        // print('url to load is:' + addBankResponse.data!);//'https://flutter.dev'
        Utils.launchURL(addBankResponse.data!);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'], AppColors.red);
      }
    } finally {
      isAddBank(false);
    }
    update();
  }

  removeBank(BuildContext context, String bankId) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
        'bank_id': bankId
      };

      var response = await DioClient().request(context: context,
          api: '/delete-funding-source', method: Method.POST, params: request);

      DeleteFundSourceResponse deleteFundSourceResponse =
          DeleteFundSourceResponse.fromJson(response);
      if (deleteFundSourceResponse.status == Strings.success) {
        Utils.showSnackbar(context, Strings.success,
            deleteFundSourceResponse.message!, AppColors.green);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'], AppColors.red);
      }
    } finally {
      isLoading(false);
      fetchfundingSources(context);
    }
    update();
  }

  removeCard(BuildContext context, String cardId) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
        'card_id': cardId
      };

      var response = await DioClient().request(context: context,
          api: '/delete-funding-source', method: Method.POST, params: request);

      DeleteFundSourceResponse deleteFundSourceResponse =
          DeleteFundSourceResponse.fromJson(response);
      if (deleteFundSourceResponse.status == Strings.success) {
        allCards.clear();
        allBankAccounts.clear();
        Utils.showSnackbar(context, Strings.success,
            deleteFundSourceResponse.message!, AppColors.green);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'], AppColors.red);
      }
    } finally {
      isLoading(false);
      fetchfundingSources(context);
    }
    update();
  }
}
