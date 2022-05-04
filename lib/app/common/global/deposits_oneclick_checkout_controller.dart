import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class PayWithDepositsController extends GetxController {
  final isLoading = false.obs;
  ChargeFundResponse finalChargeFundResponse = ChargeFundResponse();
  
   payWithCard(BuildContext context,  ValueChanged<ChargeFundResponse>? chargeFundResponse)async {
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
        print(request);
        var response = await DioClient().request(context: context,api:'/charge-funding-source',method:Method.POST ,params: request);
        if(response !=null){
        ChargeFundResponse chargeFundResponse = ChargeFundResponse.fromJson(response) ;
        if (chargeFundResponse.status == Strings.success) {
          chargeFundResponse = chargeFundResponse;
          finalChargeFundResponse = chargeFundResponse;
          Utils.navigationReplace(context, Successful(
                    successTitle: Strings.paymentSuccessful,
                    successMessage: Strings.paymentSuccessmgs),
          );
          } else {
            return Utils.showSnackbar(context, Strings.error,response['message'],  AppColors.red);
          }
        }
        } finally {
        isLoading(false);
      }
      update();
  }

   payWithBank(BuildContext context, ValueChanged<ChargeFundResponse>? chargeFundResponse) async {
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
          'account_id' : Storage.getValue(Constants.bankId),
          'meta' : meta
        };
        var response = await DioClient().request(context: context,api:'/charge-funding-source',method:Method.POST ,params: request);
        if (response != null) {
        ChargeFundResponse chargeFundResponse = ChargeFundResponse.fromJson(response) ;
        if (chargeFundResponse.status == Strings.success) {
          chargeFundResponse = chargeFundResponse;
          finalChargeFundResponse = chargeFundResponse;
          Utils.navigationReplace(context, Successful(
                    successTitle: Strings.paymentSuccessful,
                    successMessage: Strings.paymentSuccessmgs,),
          );
          } else {
           return Utils.showSnackbar(context, Strings.error,response['message'],  AppColors.red);
         }
      }
        } finally {
        isLoading(false);
      }
      update();
   }

}
