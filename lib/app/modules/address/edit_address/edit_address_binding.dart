import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class EditAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditAddressController>(() => EditAddressController());
  }
}