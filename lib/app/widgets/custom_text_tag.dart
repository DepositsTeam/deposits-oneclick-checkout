
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class CustomTextTag extends StatelessWidget {
  final String text;

  const CustomTextTag({Key? key, required this.text}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        child: Container(
          width: 70,
          height: 30,
          color: AppColors.tagBackground,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(text,
                  style: const TextStyle(fontSize: 14.0, color: AppColors.tagTextColor)),
            ),
          ),
        ),
      ),
    );
  }
}
