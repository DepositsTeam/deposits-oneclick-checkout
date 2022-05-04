import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    this.label,
    this.height,
  });

  final String? label;
  final double? height;

  @override
  Widget build(BuildContext context) {

    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin:  EdgeInsets.only( right: (15.0)),
            child: Divider(
              color: const Color(0xFF8895A7),
              height: height,
            )),
      ),

      CustomText(text: label??'', txtColor: const Color(0xFF8895A7),),

      Expanded(
        child: Container(
            margin:  EdgeInsets.only(left:(15.0)),
            child: Divider(
              color: const Color(0xFF8895A7),
              height: height,
            )),
      ),
    ]);
  }
}
