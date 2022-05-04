import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class PayWithBankCardController extends GetxController {
  var isLoading = false.obs;
  final globalKey = GlobalKey<ScaffoldState>();



  void payWithCard(BuildContext context){
   // print('personal token is:'+Storage.getValue(Constants.token));
    Utils.navigationPush(context,const PayWithCard());
  }

   void payWithBank(BuildContext context) {
    Utils.navigationPush(
        context,
        AddBank(
          pageTitle:Strings.payWithBank ,
        ));
  }

}