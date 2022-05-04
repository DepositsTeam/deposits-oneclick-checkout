import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomBackButton extends StatelessWidget {
  final Widget? leading;
  final Function()? onBackTap;
  final Color? backbuttonColor;

  const CustomBackButton({
    Key? key,
    this.leading,
    this.onBackTap,
    this.backbuttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onBackTap ?? () => Get.back(),
      icon: leading ??
          Icon(
            Icons.arrow_back_ios,
            color: backbuttonColor ?? Get.theme.primaryIconTheme.color,
          ).paddingOnly(left: 10),
    );
  }
}
