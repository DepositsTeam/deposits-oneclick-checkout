import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AddressController extends GetxController {
  var isLoading = false.obs;
   var isError = false.obs;
  var errorMessage = ''.obs;
  RxList<Datum> addresses = <Datum>[].obs;


//----------------------------------------------
  void fetchUserAddress(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };
      var response = await DioClient()
          .request(context: context,api: '/address/get', method: Method.POST, params: request);

      GetAddressResponse getAddressResponse = GetAddressResponse.fromJson(response);
      if (getAddressResponse.status == Strings.success) {
        addresses = getAddressResponse.data!.obs;
      } else {
          isError(true);
        errorMessage.value = response['message'].toString().toTitleCase();
        return Utils.showSnackbar(
            context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
      }
    } finally {
      isLoading(false);
    }
    update();
  }

//----------------------------------------------
  void addMailingAddress(BuildContext context){
    Utils.navigationPush(context,const AddAddress());
  }

//----------------------------------------------

 void editMailingAddress(BuildContext context, Datum  userAddress){
    Utils.navigationPush(context,EditAddress(
      userAddress: userAddress,
      ));
  }
}