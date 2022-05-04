
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class LinkedDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LinkedDetailsController>(() => LinkedDetailsController());
  }
}