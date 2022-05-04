import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class ImageLoader extends StatelessWidget {
  final String image;
  final BoxFit? fit;
  final double? width, height;
  const ImageLoader(this.image, {Key? key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      fit: fit,
      width: width,
      height: height,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
            child: SpinKitFadingCircle(
          color: AppColors.activButtonColor,
          size: 20,
        ));
      },
    );
  }
}
