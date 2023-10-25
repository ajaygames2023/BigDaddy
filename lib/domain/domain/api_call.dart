import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../../config/http/intersecption.dart';
import '../../utils/enum.dart';
import '../../utils/print.dart';
import 'api_constants.dart';
import 'api_model.dart';

class ApiCalls {
  ApiCalls._();
  static final instance = ApiCalls._();
  Future<ApiModel> post(
      {required String url,
      dynamic body,
      Map<String, dynamic>? params,
      Map<String, String>? header}) async {
    // try {
    // println(PrintTag.v, body);
    final responseData = await dio.post(url, data: body, queryParameters: params, options: Options(headers: header));
    println(PrintTag.i,
        "body:- $body, url:- $url\n, code:- ${responseData.statusCode}  \n ${responseData.data}");
    if (responseData.statusCode == 200) {
      var jsonData = jsonDecode(jsonEncode(responseData.data));
      if (jsonData["respCode"].toString() == "205" ||
          jsonData["respCode"].toString() == "206") {
        // CommonUtils.instance.showGetDialog(
        //     jsonData["message"] ?? TestConstants.restrictedAccess);
      }
      return ApiModel(
          apiStatus: ApiStatus.success,
          response: responseData,
          message: "Success");
    } else if (responseData.statusCode == 400 ||
        responseData.statusCode == 401) {
      return ApiModel(
          apiStatus: ApiStatus.authentication,
          response: responseData,
          message: "Auth Failed");
    } else if (responseData.statusCode == 500 ||
        responseData.statusCode == 502 ||
        responseData.statusCode == 521) {
    //  Helper.toast('There is some internal issue.Please revisit in sometime');
      return ApiModel(
          apiStatus: ApiStatus.server,
          response: null,
          message: "Server Failed");
    } else if (responseData.statusCode == 524) {
   //   Helper.toast('There is some internal issue.Please revisit in sometime');
      return ApiModel(
          apiStatus: ApiStatus.error,
          response: 'Connection Time out',
          message: "Request Failed");
    } else {
      return ApiModel(
          apiStatus: ApiStatus.server,
          response: null,
          message: "Server Failed");
    }
    // } catch (e) {
    //   println(PrintTag.e, e.toString());
    //   return ApiModel(apiStatus: ApiStatus.error, response: e.toString(),
    //       message: "Request Failed");
    // }
  }

  Future<ApiModel> get(
      {required String url,
      Map<String, dynamic>? params,
      Map<String, String>? header}) async {
    try {
      final responseData = await dio.get(url,
          queryParameters: params, options: Options(headers: header));
      println(PrintTag.i,
          "url:- $url\n, code:- ${responseData.statusCode}  \n ${responseData.data}");
      if (responseData.statusCode == 200) {
        // if (url == Urls.fetchUpcomingMatches ||
        //     url == Urls.fetchUserMatches ||
        //     url == Urls.getWallet ||
        //     url == Urls.versionUpdate ||
        //     url == Urls.getUserTDS) {
        // } else {
        //   var jsonData = jsonDecode(responseData.data);
        //   // if (jsonData["respCode"].toString() == "205" ||
        //   //     jsonData["respCode"].toString() == "206") {
        //   //   CommonUtils.instance.showGetDialog(
        //   //       jsonData["message"] ?? TestConstants.restrictedAccess);
        //   // }
        // }
        return ApiModel(
            apiStatus: ApiStatus.success,
            response: responseData,
            message: "Success");
      } else if (responseData.statusCode == 400 ||
          responseData.statusCode == 401) {
        return ApiModel(
            apiStatus: ApiStatus.authentication,
            response: responseData,
            message: "Auth Failed");
      } else if (responseData.statusCode == 500) {
        return ApiModel(
            apiStatus: ApiStatus.server,
            response: null,
            message: "Server Failed");
      } else if (responseData.statusCode == 524) {
       // Helper.toast('There is some internal issue.Please revisit in sometime');
        return ApiModel(
            apiStatus: ApiStatus.error,
            response: 'Connection Time out',
            message: "Request Failed");
      } else {
        return ApiModel(
            apiStatus: ApiStatus.server,
            response: null,
            message: "Server Failed");
      }
    } catch (e) {
      println(
          PrintTag.e,
          ""
          "$url\nerror:- ${e.toString()}");
      return ApiModel(
          apiStatus: ApiStatus.error,
          response: e.toString(),
          message: "Request Failed");
    }
  }
}
