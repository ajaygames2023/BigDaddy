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
  final formKey = GlobalKey<FormState>();
  bool isLoading = true;
  bool passwordVisible = false;
  Map<String, dynamic>? userLogin;


  void onLogin() {
    userId.text = '';
    password.text = '';
    Get.toNamed((Helper.roleId != 1) ? Routes.login : Routes.items,);
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
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      Helper.toast('Please fill correct credentials');
    } else {
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
        Helper.roleId = userLogin?['respData']['roleId'] ?? 3;
        Helper.userName = userLogin?['respData']['name'].toString() ?? '';
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

  
}
