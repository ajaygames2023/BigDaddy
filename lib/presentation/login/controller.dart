import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/router/routes.dart';
import '../../domain/models/messages.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/api_calls.dart';
import '../../utils/helper/helper.dart';

class LoginController extends GetxController {

  bool isLoading = true;
  TextEditingController pinEditingController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isOTP = false;
  Message? sendOtp; 
  Map<String, dynamic>? verifyOtp;
  UserDetails? userDetails;

    @override
  void onInit() async {
    isOTP = false;
    super.onInit();
  }

  String validateMobile(String value) {
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    }
    return 'null';
  }

  // signInOtp(): used to send otp
  void signInOtp() async {
    try {
      loadingData();
      final params = <String, dynamic>{
        'mobileNbr': phoneController.text,
        ...Helper.instance.getParams()
      };
      sendOtp = await ApiCallRepo.instance.login(params);
      if (sendOtp?.respCode == 100) {
        Helper.toast(sendOtp?.message ?? '');
        isOTP = true;
      } else {
        Helper.toast(sendOtp?.message ?? '');
      }
      update();
    } catch (e) {
      rethrow;
    } finally {
      loadingData();
    }
  }

    // login(): used to verify otp and login to home
  void login() async {
    final params = <String, dynamic>{
      "otp": pinEditingController.text,
      'mobileNbr': phoneController.text,
      ...Helper.instance.getParams(),
    };
    try {
      loadingData();
      verifyOtp = await ApiCallRepo.instance.verifyOtp(params);
      if (verifyOtp?['respCode'] == 100) {
          userDetails = UserDetails.fromJson(verifyOtp?['respData']!);
          Get.toNamed(Routes.verification);
        Helper.token = userDetails?.token ?? '';
        Helper.customerId = userDetails?.userId.toString() ?? '';
        Helper.customerName = userDetails?.screenName.toString() ?? '';
        Helper.customerMobileNbr = phoneController.text;
        Future.delayed(const Duration(milliseconds: 100), () {
          pinEditingController.clear();
          phoneController.clear();
          update();
          isOTP = false;
          });
      } else {
            //  verifyOtp = Message.fromJson(verifyOtp!) as Map<String, dynamic>?;
        Helper.toast(verifyOtp?['message']);
      }
    } catch (e) {
      rethrow;
    } finally {
      loadingData();
    }
  }



  void loadingData(){
    isLoading = !isLoading;
    update();
  }


}
