import 'package:dio/dio.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    // print('REQUEST[${options.method}] => PATH: ${options.path}');
    // print('REQUEST[QUERYPARAMETERS] => PARAMS: ${options.queryParameters}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print(
      'RESPONSE[CODE] => PATH: ${response.statusCode}',
    );
    // ignore: avoid_print
    // print(
    //   'RESPONSE[RESPONSE BODY] => RESPONSE FROM SERVER: ${response.data.toString()}',
    // );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    // print(
    //   'ERROR[CODE] => PATH: ${err.response?.statusCode}',
    // );
    // ignore: avoid_print
    // print(
    //   'ERROR[RESPONSE BODY] => RESPONSE FROM SERVER: ${err.response?.data.toString()}',
    // );
    return super.onError(err, handler);
  }
}