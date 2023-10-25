import 'dart:async';
import 'package:get/get.dart';
import '../../config/router/routes.dart';
class SplashController extends GetxController {

    @override
  void onInit() async {
    Future.delayed(const Duration(seconds: 1), () {
      navigateToLogin();
     });
    super.onInit();
  }

  void navigateToLogin() {
    Get.offNamed(Routes.loginUser);
  }

  
}
