
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';
import 'package:flutter/gestures.dart';

class CustomRichTextWidget extends StatelessWidget {
  final String? title, title2,subtitle, subtitle2,subtitle3;
  final Function()? onSubtitleTap,onSubtitleTap2,onSubtitleTap3;
  final TextStyle? titleStyle,titleStyle2, subtitleStyle,subtitleStyle2,subtitleStyle3;
  final TextAlign textAlign;

  const CustomRichTextWidget({
    Key? key,
    this.title,
    this.title2,
    this.subtitle,
    this.subtitle2,
    this.subtitle3,
    this.onSubtitleTap,
    this.onSubtitleTap2,
    this.onSubtitleTap3,
    this.titleStyle,
    this.titleStyle2,
    this.subtitleStyle,
    this.subtitleStyle2,
    this.subtitleStyle3,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        text: title,
        style: titleStyle ??
            AppTextStyle.regularStyle.copyWith(
              color: AppColors.mineShaft,
              fontSize: Dimens.fontSize14,
            ),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()
          ..onTap = onSubtitleTap,
            text: ' $subtitle',
            style: subtitleStyle ??
                AppTextStyle.regularStyle.copyWith(
                  fontSize: Dimens.fontSize14,
                  color: AppColors.activButtonColor
                ),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()
          ..onTap = onSubtitleTap2,
            text: ' $subtitle2',
            style: subtitleStyle2 ??
                AppTextStyle.regularStyle.copyWith(
                  fontSize: Dimens.fontSize14,
                  color: AppColors.activButtonColor
                ),
          ),
          TextSpan(
        text: title2,
        style: titleStyle2 ??
            AppTextStyle.regularStyle.copyWith(
              color: AppColors.mineShaft,
              fontSize: Dimens.fontSize14,
            )
          ),

          TextSpan(
            recognizer: TapGestureRecognizer()
          ..onTap = onSubtitleTap3,
            text: ' $subtitle3',
            style: subtitleStyle3 ??
                AppTextStyle.regularStyle.copyWith(
                  fontSize: Dimens.fontSize14,
                  color: AppColors.activButtonColor
                ),
          ),
        ],
      ),
    );
  }
}
