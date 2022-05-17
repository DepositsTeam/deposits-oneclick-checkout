import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
import 'package:deposits_oneclick_checkout/app/model/me/me_response.dart';

class ProfileController extends GetxController {
  var isLoading = false.obs;
  Rx<User> user = User().obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
//----------------------------------------------
  void editProfile(BuildContext context) {
    Utils.navigationPush(
        context,
        EditProfile(
          user: user.value,
        ));
  }

//----------------------------------------------
  void fetchUserProfile(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };
      var response = await DioClient().request(
          context: context, api: '/me', method: Method.POST, params: request);

      MeResponse meResponse = MeResponse.fromJson(response);
      if (meResponse.status == Strings.success) {
        user = meResponse.data!.user!.obs;
        isError(false);
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        if (errorMessage.value == 'Token Not Valid') {
          Utils.navigationReplace(context, const Login());
          return Utils.showSnackbar(
              context, Strings.error, 'Token has expired please login again!.', AppColors.red);
        }
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
//----------------------------------------------

}
