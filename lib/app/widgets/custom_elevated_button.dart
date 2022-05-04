import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomElevatedButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final double height, minWidth;
  final Widget? titleWidget;
  final Color buttonColor,buttonBorderColor, textColor, loaderColor;
  final bool addBorder;
  final bool isBusy;

  const CustomElevatedButton({
    Key? key,
    this.title,
    required this.onPressed,
    this.textStyle,
    this.height = 55,
    this.minWidth = 100,
    this.buttonColor = AppColors.activButtonColor,
    this.buttonBorderColor = AppColors.borderButtonColor,
    this.textColor = AppColors.black,
    this.loaderColor = AppColors.white,
    this.titleWidget,
    this.addBorder = false,
    this.isBusy = false,
  })  : assert(
          title == null || titleWidget == null,
          'Cannot provide both a title and a child\n'
          'To provide both, use "titleWidget: Text(title)".',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        minimumSize: MaterialStateProperty.resolveWith<Size>(
          (states) => Size(
            minWidth,
            height,
          ),
        ),
        shape: addBorder
            ? MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                (states) => RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(2),
                  side: BorderSide(
                    color: buttonColor == AppColors.activButtonColor
                        ? Colors.white
                        : buttonBorderColor,
                    width: 2,
                  ),
                ),
              )
            : MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                (states) => RoundedRectangleBorder(
                  borderRadius:BorderRadius.circular(4),
                ),
              ),
            //  AppTheme.theme.textButtonTheme.style!.shape,
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.transparent;
            }

            return null;
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return buttonColor.withOpacity(.50);
            }
            return  !isBusy? buttonColor : buttonColor.withOpacity(0.6);
          },
        ),
      ),
      child: !isBusy? titleWidget ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title!,
                style: textStyle ??
                    AppTextStyle.boldStyle.copyWith(
                      fontSize: Dimens.fontSize14,
                      color: buttonColor == Colors.white ||
                              buttonColor == Colors.transparent || buttonColor == AppColors.declineColor
                          ? textColor
                          : Colors.white,
                    ),
              ),
            ],
          )
          :  SpinKitFadingCircle(
              color: loaderColor,
              size: 20,
            ),
    );
  }
}
