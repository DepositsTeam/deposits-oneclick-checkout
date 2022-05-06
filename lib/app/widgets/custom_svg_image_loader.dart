import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class SvgImageLoader extends StatelessWidget {
  final String image;
  final BoxFit? fit;
  final double? width, height;
  const SvgImageLoader(this.image, {Key? key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      image,
      fit: fit!,
      width: width,
      height: height,
      placeholderBuilder: (context) => Center(
            child: SpinKitFadingCircle(
          color: AppColors.activButtonColor(),
          size: 20,
        )),
    );
  }
}
