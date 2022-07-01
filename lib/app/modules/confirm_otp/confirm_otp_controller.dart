import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class ConfirmOtpController extends GetxController {
  var isLoading = false.obs;
  var isResendLoading = false.obs;
  var offStageAuthoriseButton = false.obs;
  var offStageRequestButton = false.obs;
  final formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final otpController = TextEditingController();
  LoginController loginController = Get.find();
  Rx<Cards> primaryCard = Cards().obs;

  Future<void> fetchfundingSources(BuildContext context) async {
    try {
      isLoading(true);
      offStageRequestButton(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };
      var response = await DioClient().request(
          context: context,
          api: '/get-funding-sources',
          method: Method.POST,
          params: request);

      GetFundingResponse getFundingResponse =
          GetFundingResponse.fromJson(response);
      if (getFundingResponse.status == Strings.success) {
        var allCards = getFundingResponse.data!.cards!.obs;
        if (allCards.isNotEmpty) {
          for (Cards card in allCards) {
            if (card.primaryCard == "true") {
              primaryCard.value = card;
              Storage.removeValue(Constants.cardNumber);
              Storage.removeValue(Constants.cardId);
              Storage.saveValue(Constants.isCardAdded, true);
              Storage.saveValue(
                  Constants.cardId, primaryCard.value.id.toString());
              Storage.saveValue(Constants.cardNumber,
                  primaryCard.value.metaDataJson!.maskedCardNumber!);
              // Utils.navigationReplace(
              //     context,
              //     Successful(
              //       successTitle: 'Cards fetched Successfully',
              //       successMessage: DateFormat.jm().format(
              //           DateTime.parse(DateTime.now().toString()).toLocal()),
              //     ));
            } else {
              primaryCard.value = allCards.first;
              Storage.removeValue(Constants.cardNumber);
              Storage.removeValue(Constants.cardId);
              Storage.saveValue(Constants.isCardAdded, true);
              Storage.saveValue(Constants.cardNumber,
                  allCards.first.metaDataJson!.maskedCardNumber!);
              Storage.saveValue(Constants.cardId, allCards.first.id.toString());

            }
          }
          Utils.navigationReplace(
              context,
              Successful(
                successTitle: 'Cards fetched Successfully',
                successMessage: DateFormat.jm().format(
                    DateTime.parse(DateTime.now().toString()).toLocal()),
              ));
          // Navigator.of(context).pop();
        } else {
          Utils.navigationReplace(context, const PayWithBankCard());
          Utils.showSnackbar(context, Strings.success,
              getFundingResponse.message!, AppColors.green);
        }
      } else {
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
      offStageRequestButton(false);
    }
    update();
  }

//-----------------------------------------------
  void authoriseOtp(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      isLoading(true);
      offStageRequestButton(true);

      var request = {
        'email': Storage.getValue(Constants.userEmail),
        'code': otpController.text.toString(),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };

      var response = await DioClient().request(
          context: context,
          api: '/verify-user',
          method: Method.POST,
          params: request);

      VerifyUserResponse verifyUserResponse =
          VerifyUserResponse.fromJson(response);
      if (verifyUserResponse.status == Strings.success) {
        Storage.removeValue(Constants.token);
        Storage.saveValue(Constants.token, verifyUserResponse.data!.token);
        await fetchfundingSources(context);
      } else {
        isLoading(false);
        offStageRequestButton(false);
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    }
  }

  void resendOtp(BuildContext context) async {
    try {
      isResendLoading.value = true;
      offStageAuthoriseButton.value = true;

      var request = {
        'email': Storage.getValue(Constants.userEmail),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };

      var response = await DioClient().request(
          context: context,
          api: '/resend-otp',
          method: Method.POST,
          params: request);

      ResendOtpResponse resendOtpResponse =
          ResendOtpResponse.fromJson(response);
      if (resendOtpResponse.status == Strings.success) {
        Utils.showSnackbar(context, Strings.success, resendOtpResponse.message!,
            AppColors.green);
      } else {
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } on DioError catch (e) {
      return Utils.showSnackbar(context, Strings.error,
          Utils.handleErrorComing(e).toTitleCase(), Colors.red);
    } catch (e) {
      isLoading(false);
      return Utils.showSnackbar(
          context, Strings.error, e.toString().toTitleCase(), Colors.red);
    } finally {
      isResendLoading(false);
      offStageAuthoriseButton(false);
    }
    update();
  }
}
