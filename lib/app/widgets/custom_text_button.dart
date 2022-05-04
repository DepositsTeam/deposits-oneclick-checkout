import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String? title;
  final double height;
  final double? buttonWidth, textFontSize;
  final Widget? child;
  final Color buttonColor;
  final bool addBorder;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    this.title,
    this.height = 52,
    this.child,
    this.buttonColor = AppColors.activButtonColor,
    this.buttonWidth,
    this.textFontSize,
    this.addBorder = false,
  })  : assert(
          title == null || child == null,
          'Cannot provide both a title and a child\n'
          'To provide both, use "child: Text(title)".',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: AppTheme.theme.textButtonTheme.style!.copyWith(
        minimumSize: MaterialStateProperty.resolveWith<Size>(
          (states) => buttonWidth == null
              ? Size.fromHeight(height)
              : Size(
                  buttonWidth!,
                  height,
                ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return buttonColor == Colors.transparent ||
                      buttonColor == Colors.white
                  ? AppColors.white
                  : Colors.white.withOpacity(.14);
            }

            return null;
          },
        ),
        shape: addBorder
            ? MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                (states) => RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                  side: BorderSide(
                    color: buttonColor == AppColors.activButtonColor
                        ? Colors.white
                        : AppColors.activButtonColor,
                    width: 2,
                  ),
                ),
              )
            : AppTheme.theme.textButtonTheme.style!.shape,
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.doveGray;
            }

            return buttonColor;
          },
        ),
      ),
      child: child ??
          Text(
            title!,
            style: AppTextStyle.buttonTextStyle.copyWith(
              fontSize: textFontSize ?? Dimens.fontSize16,
              color: buttonColor == Colors.white ||
                      buttonColor == Colors.transparent
                  ? AppColors.activButtonColor
                  : Colors.white,
            ),
          ),
    );
  }
}
