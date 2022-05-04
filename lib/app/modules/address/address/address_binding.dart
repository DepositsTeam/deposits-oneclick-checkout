import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class AddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
  }
}