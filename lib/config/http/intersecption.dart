import 'package:dio/dio.dart';

import 'dio_exception.dart';

var dio = Dio();
CancelToken? cancelToken = CancelToken();

class ApiProvider {
  static void setAuthInterceptor() async {
    dio.options
      ..connectTimeout = 120000 as Duration? //2m
      ..receiveTimeout = 120000 as Duration?; //2m
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      var customHeaders = {
        'content-type': 'application/json',
        'mobile': 1,
        'Authorization': '',
        'app-version': '',
      };
      if (!(options.queryParameters['isGlobalCancelTokenAvoided'] ?? false)) {
        options.cancelToken = cancelToken = CancelToken();
      }
      options.headers.addAll(customHeaders);
      return handler.next(options);
    }, onResponse: (response, handler) {
      return handler.next(response); // continue
    }, onError: (DioError error, handler) {
      if (error.type != DioErrorType.cancel) {
        final params = error.requestOptions.queryParameters;
        final errorMessage = DioExceptions.fromDioError(error).toString();
        if (!(params['ignoreToast'] ?? false)) {
          print(errorMessage);
        }
        return handler.next(error);
      }
    }));
  }
}
