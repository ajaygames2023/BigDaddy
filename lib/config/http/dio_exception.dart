
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../router/routes.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "request_to_api_was_cancelled".tr;
        break;
      // case DioErrorType.connectTimeout:
      //   message = "connect_time_out_from_api".tr;
      //   break;
      // case DioErrorType.other:
      //   message = "connection_to_server_failed_due_to_internt_connection".tr;
      //   break;
      case DioErrorType.receiveTimeout:
        message = "receive_timeout_in_connection_with_api_server".tr;
        break;
      // case DioErrorType.response:
      //   message = _handleError(
      //       dioError.response!.statusCode, dioError.response!.data);
      //   break;
      case DioErrorType.sendTimeout:
        message = "send_timeout_in_connection_with_api_server".tr;
        break;
      default:
        message = 'something_went_wrong'.tr;
        break;
    }
  }

  late String message;

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'bad_request'.tr;
      case 401:
        Get.offNamedUntil(Routes.login, (route) => false);
      //  preferences.removeAll();
        return 'access_denied_please_login_again'.tr;
      case 404:
      case 403:
      case 500:
        return error["error"]["message"];
      case 412:
        if (error["error"]["validation"] != null) {
          var firstKey = "";

          var validations = error["error"]["validation"];

          for (var key in error["error"]["validation"].keys.toList()) {
            firstKey = key;
            break;
          }

          if (validations[firstKey] != null &&
              validations[firstKey][0] != null) {
            return validations[firstKey][0];
          } else {
            return validations[firstKey];
          }
        } else if (error["error"]["message"] != null) {
          return error["error"]["message"];
        } else {
          return 'something_went_wrong'.tr;
        }
      default:
        return 'something_went_wrong'.tr;
    }
  }

  @override
  String toString() => message;
}
