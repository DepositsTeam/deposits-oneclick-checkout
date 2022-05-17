import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class LinkedController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var errorMessage = ''.obs;
  RxList<Tenant> allAccounts = <Tenant>[].obs;

  void fetchLinked(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };
      var response = await DioClient().request(
          context: context,
          api: '/get-all-accounts',
          method: Method.POST,
          params: request);

      LinkedResponse linkedResponse = LinkedResponse.fromJson(response);
      if (linkedResponse.status == Strings.success) {
        allAccounts = linkedResponse.data!.tenants!.obs;
        isError(false);
      } else {
        isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        if (errorMessage.value == 'Token Not Valid') {
          Utils.navigationReplace(context, const Login());
          return Utils.showSnackbar(context, Strings.error,
              'Token has expired please login again!.', AppColors.red);
        }
        return Utils.showSnackbar(context, Strings.error,
            response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
    }
    update();
  }
}
