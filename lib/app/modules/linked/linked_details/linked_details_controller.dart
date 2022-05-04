import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
import 'package:deposits_oneclick_checkout/app/model/linked/revoke_access_response.dart';

class LinkedDetailsController extends GetxController {
  var isLoading = false.obs;
  void learnMore() {}
  LinkedController linkedController = Get.find();

  revokeLinkAccess(BuildContext context, String title, Widget initialScreen,
      String linkedId) async {
    try {
      isLoading.value = true;

      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey),
      };

      var response = await DioClient().request(context: context,
          api: '/revoke-account-access/$linkedId',
          method: Method.POST,
          params: request);

      RevokeAccessResponse revokeAccessResponse =
          RevokeAccessResponse.fromJson(response);
      if (revokeAccessResponse.status == Strings.success) {
        Navigator.pop(context);
        Utils.showLinkedSnackbar(context, true, title);
        linkedController.fetchLinked(context);
      } else {
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}
