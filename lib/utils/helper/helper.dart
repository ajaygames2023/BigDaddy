import 'dart:io';
import 'package:casino/global_widgets/bottom_sheet/index.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../global_widgets/bottom_sheet/controller.dart';

class Helper {
  Helper._();
  static final instance = Helper._();
  static String deviceTypes() {
    return 'WEB_DESKTOP'; 
    // if (Platform.isAndroid || Platform.isIOS) {
    //   return 'WEB_TABLET';
    // } else {
    //   return 'WEB_DESKTOP';
    // }
  }
  static int roleId = 3;
  bool isUserOnBoarded = false;
  static String usertoken = '';
  static String token = '';
  static String userId = '';
  static String userName = '';
  static String customerId = '';
  static String customerMobileNbr = '';
  static const int gId = 1;
  static int ts = DateTime.now().millisecondsSinceEpoch * 1000;
  static String deviceType = deviceTypes();
  double currentTime = 0;
  static String customerName = '';
  static String bussinessDate = '01-01-2023';

  Map<String, dynamic> getParams() {
    return <String, dynamic>{
      'deviceType': deviceType,
      'gId': gId,
      "token": token,
      'ts': ts,
      'userId': userId,
      'customerId':customerId,
    };
  }

  static void toast(String title, {Duration? duration,String? status}) {
    // Fluttertoast.showToast(
    //     msg: title,
    //     toastLength: toastLength ?? Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: const Color.fromARGB(255, 250, 198, 65),
    //     textColor: CasinoColors.black,
    //     fontSize: 16.0);
      Get.snackbar(status ?? 'Error', title,backgroundColor: CasinoColors.secondary,colorText: CasinoColors.primary,duration: duration ?? const Duration(seconds: 1));
  }

  static void openBottomSheet({required Widget Function(CasinoBottomSheetController) child}) {
    Get.bottomSheet(
      CasinoBottomSheet(child: child),
      backgroundColor: CasinoColors.secondary,
      ignoreSafeArea: false,
      isDismissible: false,
        shape: const RoundedRectangleBorder( // <-- SEE HERE
          borderRadius: BorderRadius.vertical( 
            top: Radius.circular(20.0),
          ),
          side: BorderSide(
          color: CasinoColors.primary
        ) 
        ),
    );
  }
}
