import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../config/router/routes.dart';
import '../../domain/repositories/api_calls.dart';
import '../../utils/helper/helper.dart';
class UserLoginController extends GetxController {

  TextEditingController userId = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = true;
  Map<String, dynamic>? userLogin;


  void onLogin() {
    userId.text = '';
    password.text = '';
    Get.toNamed(Routes.login);
    update();
  }

   void loadingData(){
    isLoading = !isLoading;
    update();
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  void getUserLogin() async {
    // Get.dialog(
    //   DialogBox(title: 'Chips', child: Text('abc'))
    // );
    final params = <String, dynamic>{
      "email": userId.text,
      'password': generateMd5(password.text),
    //  ...Helper.instance.getParams(),
    };
    try {
      loadingData();
      userLogin = await ApiCallRepo.instance.userLogin(params);
      if (userLogin?['respCode'] == 100) {
        Helper.userId = userLogin?['respData']['adminId'].toString() ?? '';
        Helper.usertoken = userLogin?['respData']['token'].toString() ?? '';
        onLogin();
      } else {
        Helper.toast(userLogin?['message']);
      }
    } catch (e) {
      rethrow;
    } finally {
      loadingData();
    }
  }

  
}
