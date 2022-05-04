
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomInkwellWidget extends Material {
  CustomInkwellWidget({
    Key? key,
    required Function() onTap,
    required Widget child,
  }) : super(
          key: key,
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.transparent,
            hoverColor:Colors.transparent,
            highlightColor: Colors.transparent,
            child: child.paddingAll(8),
          ),
        );

  CustomInkwellWidget.text({
    Key? key,
    required Function() onTap,
    required String title,
    TextStyle? textStyle,
    Color? textColor,
    double? textSize,
  })  : assert(
          textColor == null || textStyle == null,
          'Cannot provide both a textColor and a textStyle\n'
          'To provide both, use "textStyle: TextStyle(color: color)".',
        ),
        assert(
          textSize == null || textStyle == null,
          'Cannot provide both a textSize and a textStyle\n'
          'To provide both, use "textStyle: TextStyle(size: textSize)".',
        ),
        super(
          key: key,
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Text(
              title,
              style: textStyle ??
                  AppTextStyle.regularStyle.copyWith(
                    color: textColor,
                    fontSize: textSize,
                  ),
            ).paddingAll(8),
          ),
        );
}
