import 'package:intl/intl.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AddNewCardController extends GetxController {
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
  var userFirstName=''.obs;
  
  PaymentsController paymentsController = Get.find();

   @override
  void onInit() async{
    // var card = jsonDecode(Storage.getValue(Constants.savedCard));
    // card.cvv.toString();
    super.onInit();
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

      paymentCard.type = CardType.Others;
    cardNumberController.addListener(getCardTypeFrmNumber);
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
//------------------------------------------
  void addNewCard(BuildContext context) async{
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      // Get hold of the current form state
      final FormState form = formKey.currentState!;
      //save form values
      form.save();
      try{
      isLoading.value = true;
       var request = {
          'token': Storage.getValue(Constants.token),
          'api_key': Constants.apiKey,
          'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
          'card_name' : userFirstName.value,
          'card_number': paymentCard.number,
          'cvv' : paymentCard.cvv,
          'expiry_month' : paymentCard.month,
          'expiry_year' : paymentCard.year,
          'zip' : zipController.text.toString()
        };
      var response = await DioClient().request(context: context,api:'/tokenize-card',method:Method.POST ,params: request);

      //  TokenizeCardResponse tokenizeCardResponse = TokenizeCardResponse.fromJson(response);
    
          Map<String, dynamic> respJson =  Map<String, dynamic>.from(response);
          final String status = respJson['status'] as String;
          final String message = respJson['message'] as String;

      if (status == Strings.success) {
        Utils.navigationReplace(context, Successful(
                  successTitle: Strings.cardAddedSuccessfully,
                  successMessage: DateFormat.jm().format(DateTime.parse(DateTime.now().toString()).toLocal()),
                  ));
        paymentsController.fetchfundingSources(context);
        } else {
           return Utils.showSnackbar(context, Strings.error,message.toString().toTitleCase(),  AppColors.red);
         }
        } finally {
        isLoading(false);
      }
      update();
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
