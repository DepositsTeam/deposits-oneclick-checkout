import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomCloseButton extends StatelessWidget {
  final Widget? leading;
  final Function()? onCloseTap;
  final Color? closeButtonColor;

  const CustomCloseButton({
    Key? key,
    this.leading,
    this.onCloseTap,
    this.closeButtonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onCloseTap ?? () => Get.back(),
      icon: leading ??
          Icon(
            Icons.close,
            size: 30,
            color: closeButtonColor ?? Get.theme.primaryIconTheme.color,
          ).paddingOnly(left: 10),
    );
  }
}
