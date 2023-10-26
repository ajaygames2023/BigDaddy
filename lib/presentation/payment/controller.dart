import 'dart:async';
import 'package:get/get.dart';
import '../../config/router/routes.dart';
class PaymentController extends GetxController {

    @override
  void onInit() async {
    super.onInit();
  }

  void navigateToLogin() {
    Get.offNamed(Routes.loginUser);
  }

  
}
