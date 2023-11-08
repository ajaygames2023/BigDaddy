import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/enum.dart';
import '../../utils/print.dart';
import '../domain/api_call.dart';
import '../domain/api_constants.dart';
import '../models/card_details.dart';
import '../models/invoice/invoice_generate.dart';
import '../models/messages.dart';
import '../models/profile.dart';

class ApiCallRepo {
  ApiCallRepo._();
  static final instance = ApiCallRepo._();
  
  Future<Map<String, dynamic>> verifyOtp(Map<String, dynamic> params) async {
    try {
      final apiRes = await ApiCalls.instance.post(url: Urls.login, body: params);
      return Map.castFrom(json.decode(apiRes.response.toString()));
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> userLogin(Map<String, dynamic> params) async {
    try {
      final apiRes = await ApiCalls.instance.post(url: Urls.userLogin, body: params);
      return Map.castFrom(json.decode(apiRes.response.toString()));
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

    Future<Message> login(Map<String, dynamic> params) async {
    try {
      final apiRes = await ApiCalls.instance.post(url: Urls.validateOtp, body: params);
      return Message.fromJson(jsonDecode(apiRes.response.toString()));
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

    Future<Map<String, dynamic>> 
    panVerify(
      Map<String, dynamic> params, File image) async {
    try {
      print(image.path);
      print(image.path.split('/').last);
      var formData = FormData.fromMap({
        ...params,
        'panCardImage': await MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
      });
      print(params);
      print(formData);
      final apiRes = await ApiCalls.instance.post(url: Urls.pancardUpload, body: formData);
      return Map.castFrom(json.decode(apiRes.response.toString()));
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

   Future<Map<String, dynamic>> 
    aadharVerify(
      Map<String, dynamic> params, File frontImage, File backImage) async {
    try {
      var formData = FormData.fromMap({
        ...params,
        'aadharCardFrontimage': await MultipartFile.fromFile(frontImage.path,
            filename: frontImage.path.split('/').last),
        'aadharCardBackimage': await MultipartFile.fromFile(backImage.path,
            filename: backImage.path.split('/').last),
      });
      print(params);
      final apiRes =
          await ApiCalls.instance.post(url: Urls.aadharUpload, body: formData);
      return Map.castFrom(json.decode(apiRes.response.toString()));
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

    Future<CardDetails> getPanDetails(Map<String, dynamic> params) async {
    try {
      final apiRes =
          await ApiCalls.instance.post(url: Urls.panCardDetails, body: params);
      final jsonData = json.decode(apiRes.response.toString());
      if (jsonData['respCode'] == 404) {
        return CardDetails();
      }
      return CardDetails.fromJson(jsonData['respData']);
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

  Future<CardDetails> getAadharDetails(Map<String, dynamic> params) async {
    try {
      final apiRes = await ApiCalls.instance
          .post(url: Urls.aadharCardDetails, body: params);
      final jsonData = json.decode(apiRes.response.toString());
      if (jsonData['respCode'] == 404) {
        return CardDetails();
      }
      return CardDetails.fromJson(jsonData['respData']);
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> logout(Map<String, dynamic> params) async {
    try {
      final apiRes =
          await ApiCalls.instance.post(url: Urls.logout, body: params);
      return Map.castFrom(json.decode(apiRes.response.toString()));
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

  Future<GenerateInvoiceModel> generateInvoice(Map<String, dynamic> params) async {
    try {
      final apiRes = await ApiCalls.instance.post(url: Urls.generateInvoice, body: params);
      final jsonData = json.decode(apiRes.response.toString());
      return GenerateInvoiceModel.fromJson(jsonData['respData']);
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getKycStatus(Map<String, dynamic> params) async {
    try {
      final apiRes = await ApiCalls.instance.post(url: Urls.kycStatus, body: params);
      return Map.castFrom(json.decode(apiRes.response.toString()));
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateProfile(
      Map<String, dynamic> params) async {
    try {
      final apiRes =
          await ApiCalls.instance.post(url: Urls.profileUpdate, body: params);
      return Map.castFrom(json.decode(apiRes.response.toString()));
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }

  Future<MyProfile> myProfile(Map<String, dynamic> params) async {
    try {
      final apiRes =
          await ApiCalls.instance.post(url: Urls.myProfile, body: params);
      final jsonData =
          Map.castFrom(jsonDecode(apiRes.response?.toString() ?? ""));
      var data = MyProfile.fromJson(jsonData['respData']);
      return data;
    } catch (e) {
      println(PrintTag.e, e.toString());
      rethrow;
    }
  }


}
