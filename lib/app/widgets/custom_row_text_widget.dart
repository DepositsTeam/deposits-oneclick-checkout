import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomRowTextWidget extends StatelessWidget {
  final String title, subtitle;
  final Function()? titleOnTap, subTitleOnTap;
  final TextStyle? titleStyle, subtitleStyle;
  final MainAxisAlignment mainAxisAlignment;

  const CustomRowTextWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.titleOnTap,
    this.subTitleOnTap,
    this.titleStyle,
    this.subtitleStyle,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        InkWell(
          onTap: titleOnTap,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Text(
            title,
            maxLines: 1,
            style: titleStyle ??
                AppTextStyle.regularStyle.copyWith(
                  color: AppColors.mineShaft,
                  fontSize: (Dimens.fontSize16),
                  fontWeight: FontWeight.w600
                ),
          ),
        ),
        InkWell(
          onTap: subTitleOnTap,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          child: Text(
            subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: subtitleStyle ??
                AppTextStyle.regularStyle.copyWith(
                  color: AppColors.borderButtonColor,
                  fontSize: (Dimens.fontSize16),
                  fontWeight: FontWeight.w600
                ),
          ),
        ),
      ],
    );
  }
}
