import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final loginGlobalKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  //--------------------------------------
  void termsOnClick() {
    // debugPrint('You clicked on terms');
  }

  //--------------------------------------
  void policyOnClick() {
    // debugPrint('You clicked on terms');
  }

  //--------------------------------------
  void cookieOnClick() {
    // debugPrint('You clicked on terms');
  }

  //--------------------------------------
  void signIn(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      try {
        isLoading(true);
        var request = {
          'email': Storage.getValue(Constants.userEmail),
          'api_key': Constants.apiKey,
          'sub_client_api_key': Storage.getValue(Constants.subClientApiKey)
        };
        Dio dioService = Dio();
        dioService = Dio(BaseOptions(
          baseUrl: Constants.baseUrl(),
        ));
        (dioService.httpClientAdapter as DefaultHttpClientAdapter)
            .onHttpClientCreate = (HttpClient dioClient) {
          dioClient.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return dioClient;
        };
        // var response = await DioClient().post(Constants.baseUrl, '/auth-user', request);
        var response = await dioService.post('/auth-user', data: request);
        // .request(api: '/auth-user', method: Method.POST, params: request);
        if (response.statusCode == 200) {
          final String responseStr = jsonEncode(response.data);
          final respJson = jsonDecode(responseStr);
          final String status = respJson['status'] as String;
          final String message = respJson['message'] as String;
          if (status == Strings.success) {
            isLoading(false);
            Utils.navigationReplace(
                context, const ConfirmOtp());
            Utils.showSnackbar(
                context, Strings.success, message, AppColors.green);
          } else {
            isLoading(false);
            return Utils.showSnackbar(
                context, Strings.error, message, AppColors.red);
          }
        } else {
          isLoading(false);
          return Utils.showSnackbar(
              context, Strings.error, "message", AppColors.red);
        }

        // var response = await DioClient().request(api: '/auth-user', method: Method.POST, params: request);
        // AuthUserResponse authUserResponse = AuthUserResponse.fromJson(response);
        // if (authUserResponse.status == Strings.success) {
        //   Utils.navigationPush(
        //       context, ConfirmOtp(initialScreen: initialScreen));
        //   Utils.showSnackbar(context, Strings.success,
        //       authUserResponse.message!, AppColors.green);
        // } else {
        //   return Utils.showSnackbar(
        //       context, Strings.error, response['message'].toString().toTitleCase(), AppColors.red);
        // }
      } on DioError catch (e) {
        return Utils.showSnackbar(context, Strings.error,
            Utils.handleErrorComing(e).toTitleCase(), Colors.red);
      } catch (e) {
        isLoading(false);
        return Utils.showSnackbar(
            context, Strings.error, e.toString().toTitleCase(), Colors.red);
      } finally {
        isLoading(false);
      }
      update();
    }
  }
  //--------------------------------------
}
