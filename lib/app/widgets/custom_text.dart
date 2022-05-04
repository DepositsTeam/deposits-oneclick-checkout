import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? txtColor;
  final double? font;
  final int? maxLine;
  final FontWeight? fntweight;
  final FontStyle? fntstyle;
  final double? letterSpace;
  final TextAlign? txtAlign;
  final TextStyle? textStyle;
  final TextDecoration? textDecoration;
  final bool? softWrap;
  final TextOverflow? ellipsis;
  final GestureTapCallback? nav;

  const CustomText(
      { Key? key,
      required this.text,
      this.txtColor,
      this.txtAlign,
      this.font,
      this.maxLine,
      this.fntweight,
      this.fntstyle,
      this.letterSpace,
      this.textStyle,
      this.textDecoration,
      this.softWrap,
      this.ellipsis,
      this.nav}): super(key: key);
      
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: nav,
      child: Text(
        text== null? "null":text,
        textAlign: txtAlign,
        softWrap: softWrap,
        overflow: ellipsis,
        maxLines: maxLine ,
        style: textStyle?? TextStyle(
            decoration: textDecoration ?? TextDecoration.none,
            color: txtColor ?? AppColors.black,
            fontSize: font ?? 18,
            fontFamily: 'Poppins',
            letterSpacing: letterSpace ,
            fontStyle: fntstyle??FontStyle.normal,
            fontWeight: fntweight ),
      ),
    );
  }
}