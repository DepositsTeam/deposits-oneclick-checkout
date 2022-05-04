

import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AddBankController extends GetxController {
  RxString checkOutUrl = "na".obs;
  var isLoading = true.obs;
  final GlobalKey webViewKey = GlobalKey();

  void addBank(BuildContext context) async {
    try {
      isLoading(true);
      var request = {
        'token': Storage.getValue(Constants.token),
        'api_key': Constants.apiKey,
        'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
      };
      var response = await DioClient().request(context: context,
          api: '/get-add-bank-url', method: Method.POST, params: request);

      AddBankResponse addBankResponse = AddBankResponse.fromJson(response);
      if (addBankResponse.status == Strings.success) {
        checkOutUrl = addBankResponse.data!.obs;
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