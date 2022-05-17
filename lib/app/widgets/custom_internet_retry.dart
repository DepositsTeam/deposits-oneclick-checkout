import '../common/utils/exports.dart';

class CustomNoInternetRetry extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onPressed;

  // ignore: use_key_in_widget_constructors
  const CustomNoInternetRetry(
      {required this.title, required this.message, required this.onPressed});

  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: title,
          fntweight: FontWeight.bold,
          font: 20,
          txtColor: AppColors.black.withOpacity(0.9),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(
            text: message,
            fntweight: FontWeight.normal,
            font: 14,
            txtColor: AppColors.black),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            width: 100,
            child: CustomElevatedButton(
              buttonColor: AppColors.activButtonColor(),
              onPressed: () {
                // if (message == 'Token Not Valid') {
                //   Utils.navigationReplace(context, const Login());
                //   return Utils.showSnackbar(
                //       context, Strings.error, message, AppColors.red);
                // } else {
                  onPressed;
                // }
              },
              title: Strings.retry,
            ))
      ],
    ));
  }
}
