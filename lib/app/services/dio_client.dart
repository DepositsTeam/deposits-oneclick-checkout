import 'package:dio/dio.dart';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:deposits_oneclick_checkout/app/common/utils/exports.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

class DioClient {
  Future<dynamic> request(
      {
        required BuildContext context,
        required String api,
      required Method method,
      Map<String, dynamic>? params}) async {
    Dio _dio = Dio();
    _dio = Dio(BaseOptions(
      baseUrl: Constants.baseUrl(),
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ))
      ..interceptors.add(Logging());
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient dioClient) {
      dioClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return dioClient;
    };
    var response;
    try {
      if (method == Method.POST) {
        response = await _dio
            .post(api, queryParameters: params)
            .timeout(Constants.timeout);
      } else if (method == Method.DELETE) {
        response = await _dio.delete(api).timeout(Constants.timeout);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(api).timeout(Constants.timeout);
      } else {
        response = await _dio
            .get(api, queryParameters: params)
            .timeout(Constants.timeout);
      }
      return response.data;
    } on DioError catch (e) {
      Utils.showSnackbar(context, Strings.error,
          Utils.handleErrorComing(e).toTitleCase(), Colors.red);
    }
  }
}