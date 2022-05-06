import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomAppbarWidget extends PreferredSize {
  final String? title;
  final Color? backgroundColor;
  final Color? backbuttonColor, closeButtonColor, textColor;
  final TextStyle? textStyle;
  final List<Widget>? actions;
  final Function()? onActionButtonTap, onBackPress, onClosePress;
  final double? actionButtonWidth, textSize;
  final Widget? titleWidget, leading, onCloseLeading, bottom;
  final bool addBackButton;
  final bool addCloseButton;
  final bool? centerTitle;

  CustomAppbarWidget({
    Key? key,
    this.title,
    this.titleWidget,
    this.leading,
    this.onCloseLeading,
    this.textSize,
    this.addBackButton = true,
    this.addCloseButton = true,
    this.onBackPress,
    this.onClosePress,
    this.backgroundColor ,
    this.backbuttonColor = AppColors.white,
    this.closeButtonColor = AppColors.white,
    this.textColor,
    this.textStyle,
    this.actions,
    this.onActionButtonTap,
    this.actionButtonWidth = 100,
    this.bottom,
    this.centerTitle,
  })  : assert(
          textColor == null || textStyle == null,
          'Cannot provide both a textColor and a textStyle\n'
          'To provide both, use "textStyle: TextStyle(color: color)".',
        ),
        super(
          key: key,
          child: const SizedBox.shrink(),
          preferredSize: Size.fromHeight(bottom == null ? kToolbarHeight : 98),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      elevation: 0,
      actions: actions,
      actionsIconTheme: IconThemeData(
        size: 20,
      ),
      bottom: bottom == null
          ? null
          : PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: bottom!,
            ),
      leading: addBackButton
          ? CustomBackButton(
              leading: leading,
              onBackTap: onBackPress,
              backbuttonColor: backbuttonColor,
            )
          : addCloseButton
              ? CustomCloseButton(
                  leading: onCloseLeading,
                  onCloseTap: onClosePress,
                  closeButtonColor: closeButtonColor,
                )
              : null,
      leadingWidth: 45,
      backgroundColor: backgroundColor,
      title: title == null
          ? (titleWidget ?? const SizedBox.shrink())
          : Text(
              title!,
              style: textStyle ??
                  AppTextStyle.boldStyle.copyWith(
                    color: textColor ??
                        (backgroundColor == Colors.white
                            ? AppColors.mineShaft
                            : Colors.white),
                    fontSize: textSize ?? Dimens.fontSize20,
                  ),
            ),
    );
  }
}
