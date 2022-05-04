import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class LinkedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LinkedController>(() => LinkedController());
  }
}