import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class PayWithCardController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvcController = TextEditingController();
  final zipController = TextEditingController();
  var paymentCard = PaymentCard();
  var autoValidateMode = AutovalidateMode.disabled;
  var userFirstName = ''.obs;

  @override
  void onInit() {
    controllerVaildations();
    paymentCard.type = CardType.Others;
    cardNumberController.addListener(getCardTypeFrmNumber);
    super.onInit();
  }

  void controllerVaildations() {
    firstNameController.text = '';
    lastNameController.text = '';
    cardNumberController.text = '';
    expiryDateController.text = '';
    cvcController.text = '';
    zipController.text = '';
    firstNameController.addListener(() {
      update();
    });
    lastNameController.addListener(() {
      update();
    });
    cardNumberController.addListener(() {
      update();
    });
    expiryDateController.addListener(() {
      update();
    });
    cvcController.addListener(() {
      update();
    });
    zipController.addListener(() {
      update();
    });
  }

  @override
  void dispose() {
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvcController.dispose();
    zipController.dispose();
    // firstNameController.removeListener(dispose);
    cardNumberController.removeListener(getCardTypeFrmNumber);
  }

  void getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(cardNumberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    paymentCard.type = cardType;
  }


   void payWithCard(BuildContext context)async {
    try {
    isLoading(true);
    var visitorId = await FingerPrintJs().getVisitorId();
    var meta = {
      'ip': '',
      'fingerprint': visitorId,
      'device': 'Mobile App',
      'browser': 'Mobile App',
      'country': '',
      'city': '',
      'isp': '',
    };
    var request = {
          'token': Storage.getValue(Constants.token),
          'api_key': Constants.apiKey,
          'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
          'amount' : Storage.getValue(Constants.amountToProcess),
          'card_id' : Storage.getValue(Constants.cardId),
          'meta' : meta
        };
        var response = await DioClient().request(context: context,api:'/charge-funding-source',method:Method.POST ,params: request);
        ChargeFundResponse chargeFundResponse = ChargeFundResponse.fromJson(response) ;
        if (chargeFundResponse.status == Strings.success) {
         Utils.navigationReplace(
              context,
              Successful(
                successTitle: Strings.paymentSuccessful,
                successMessage: Strings.paymentSuccessmgs,
              ));
          Utils.showSnackbar(context, Strings.success,
              chargeFundResponse.message!, AppColors.green);
          } else {
           return Utils.showSnackbar(context, Strings.error,response['message'].toString().toTitleCase(),  AppColors.red);
         }
        } finally {
        isLoading(false);
      }
      update();
  }

//------------------------------------------
  void addCard(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      // Get hold of the current form state
      final FormState form = formKey.currentState!;
      //save form values
      form.save();
        isLoading.value = true;
        var request = {
          'token': Storage.getValue(Constants.token),
          'api_key': Constants.apiKey,
          'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
          'card_name': userFirstName.value,
          'card_number': paymentCard.number,
          'cvv': paymentCard.cvv,
          'expiry_month': paymentCard.month,
          'expiry_year': paymentCard.year,
          'zip': zipController.text.toString()
        };

        var response = await DioClient().request(context: context,
            api: '/tokenize-card', method: Method.POST, params: request);

        TokenizeCardResponse tokenizeCardResponse =
            TokenizeCardResponse.fromJson(response);
        if (tokenizeCardResponse.status == Strings.success) {
          // var json = jsonEncode(paymentCard.toJson());
          // Storage.saveValue(Constants.savedCard, json);
          // print('card number is ${paymentCard.number.toString().substring(paymentCard.number.toString().length - 4)}');
          // print('card id is ${tokenizeCardResponse.data!.id.toString()}');
          Storage.saveValue(Constants.cardNumber,
              tokenizeCardResponse.data!.metaDataJson!.maskedCardNumber);
          Storage.saveValue(
              Constants.cardId, tokenizeCardResponse.data!.id.toString());
          Storage.saveValue(Constants.isCardAdded, true);
          payWithCard(context);
        } else {
          isLoading(false);
          return Utils.showSnackbar(
              context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
        }
  }
  }

//------------------------------------------
  bool validateInput() {
    if (firstNameController.text.isEmpty) {
      return false;
    } else if (lastNameController.text.isEmpty) {
      return false;
    } else if (cardNumberController.text.isEmpty) {
      return false;
    } else if (expiryDateController.text.isEmpty) {
      return false;
    } else if (cvcController.text.isEmpty) {
      return false;
    } else if (zipController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
