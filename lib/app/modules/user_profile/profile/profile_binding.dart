
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}