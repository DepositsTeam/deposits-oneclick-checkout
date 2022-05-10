import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';


class Utils {
  static Future navigationReplace(
    BuildContext context, 
    Widget screen
    ) async {
    return await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          settings: RouteSettings(name: '/${screen.toStringShort()}'),
          builder: (context) => screen));
  }

  static void navigationPush(
    BuildContext context, 
    Widget screen,
    {VoidCallback? onComplete}
    ) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
            settings: RouteSettings(name: '/${screen.toStringShort()}'),
            builder: (context) => screen))
        .then((value) => onComplete);
  }

  static void showSnackbar(BuildContext context, String title, String message,
      Color backgroundColor) {
    Flushbar(
            margin: const EdgeInsets.all(8),
            borderRadius: BorderRadius.circular(15),
            routeBlur: 20,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 5),
            title: title,
            message: message,
            backgroundColor: backgroundColor)
        .show(context);
  }

  static void showLinkedSnackbar(
      BuildContext context, bool isSuccessful, String linkedTitle) {
    Flushbar(
            routeBlur: 20,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 5),
            messageText: Container(
              alignment: Alignment.topCenter,
              width: Get.width,
              child: Container(
                color: isSuccessful == true ? AppColors.green : AppColors.red,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    verticalSpaceMedium,
                    CustomText(
                      text: isSuccessful == true
                          ? Strings.revokedSuccessfully
                          : Strings.revokedSuccessfailed,
                      txtColor: AppColors.white,
                      font: Dimens.fontSize16,
                      fntweight: FontWeight.bold,
                    ),
                    verticalSpaceSmall,
                    CustomText(
                      text:
                          'All access to Deposits ID data remove, $linkedTitle is disconnected from Deposits ID ',
                      txtColor: AppColors.white,
                      font: Dimens.fontSize14,
                      txtAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            backgroundColor: AppColors.green)
        .show(context);
  }

  static bool getEnviromentUrl() {
    final envUrl = Storage.getValue(Constants.envMode);
    // print('derived env $envUrl');
    return envUrl;
  }

  static Widget loader() {
    return  Center(
      child: SpinKitFadingCircle(
        color: AppColors.activButtonColor(),
        size: 20,
      ),
    );
  }

  static Widget getCardImage(String? cardBrand) {
    String img = "";
    Icon? icon;
    switch (cardBrand!.toTitleCase()) {
      case 'Mastercard':
        img = 'img_mastercard.png';
        break;
      case 'Visa':
        img = 'img_visa.png';
        break;
      case 'Verve':
        img = 'img_verve.png';
        break;
      case 'Americanexpress':
        img = 'img_amex.png';
        break;
      case 'Discover':
        img = 'img_discover.png';
        break;
      case 'DinersClub':
        img = 'img_dinners_club.png';
        break;
      case 'Jcb':
        img = 'img_jcb.png';
        break;
      default:
        icon = Icon(
          Icons.circle,
          size: 40.0,
          color: AppColors.activButtonColor(),
        );
        break;
    }
    Widget? widget;
    if (img.isNotEmpty) {
      widget = CircleAvatar(
          backgroundColor: AppColors.white,
          child: Image.asset('assets/images/$img',
              width: 30.0, height: 30, package: 'deposits_oneclick_checkout'));
    } else {
      widget = icon;
    }
    return widget!;
  }

  static String getInitials(String bank_account_name) {
    List<String> names = bank_account_name.split(" ");
    String initials = "";
    int numWords = 2;
    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}';
    }
    return initials;
  }

  static String handleErrorComing(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription = "${error.response?.data['message']}";
          break;
        case DioErrorType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

// static int hexToInt(String hex) {
//     int val = 0;
//     int len = hex.length;
//     for (int i = 0; i < len; i++) {
//       int hexDigit = hex.codeUnitAt(i);
//       if (hexDigit >= 48 && hexDigit <= 57) {
//         val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
//       } else if (hexDigit >= 65 && hexDigit <= 70) {
//         // A..F
//         val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
//       } else if (hexDigit >= 97 && hexDigit <= 102) {
//         // a..f
//         val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
//       } else {
//         throw const FormatException("Invalid hexadecimal value");
//       }
//     }
//     return val;
//   }

}