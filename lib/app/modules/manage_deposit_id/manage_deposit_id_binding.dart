import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class ManageDepositIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageDepositIdController>(() => ManageDepositIdController());
    Get.lazyPut<PaymentsController>(() => PaymentsController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<AddressController>(() => AddressController());
    Get.lazyPut<LinkedController>(() => LinkedController());
  }
}