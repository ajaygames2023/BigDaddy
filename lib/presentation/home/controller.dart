import 'dart:io';

import 'package:casino/domain/domain/api_constants.dart';
import 'package:casino/domain/repositories/api_calls.dart';
import 'package:casino/global_widgets/dialog.dart';
import 'package:casino/global_widgets/pg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_upi/get_upi.dart';
import 'package:upi_india/upi_app.dart';
import 'package:upi_india/upi_india.dart';

import '../../config/router/routes.dart';
import '../../utils/helper/helper.dart';
import 'widgets/chip_dialog.dart';

class ItemsController extends GetxController {

  bool isLoading = true;
  Map<String, dynamic>? logoutRes;
  Map<String, dynamic>? generateInvoice;
  List<String> selectedList = [];
  TextEditingController chipAmount = TextEditingController();
  double totalAmount = 0;
  List<ChipsModel> chipsList = [
    ChipsModel(id: 1, title: 'Regular Pack', minAmount: '2000',image: 'assets/images/Regular-Final.png',),
    ChipsModel(id: 2,title: 'Day Time Deal Packages', minAmount: '3500',image: 'assets/images/Day-Final.png'),
    ChipsModel(id: 3,title: 'PremiumPackage', minAmount: '4500',image: 'assets/images/Premium-Final.png'),
    ChipsModel(id: 4,title: 'VIP Package', minAmount: '6000',image: 'assets/images/VIP-Final.png'),
  ];

   List<UpiObject> upiAppsList = [];
  List<UpiObject> upiAppsListAndroid = [];
  MethodChannel methodChannel = const MethodChannel("get_upi");
  UpiIndia upiIndia = UpiIndia();






  void loadingData(){
    isLoading = !isLoading;
    update();
  }

  void selectList(String item) {
    if(selectedList.contains(item)) {
      selectedList.remove(item);
    } else {
      selectedList.add(item);
    }
    update();
  }

  void onBook({required int id,required String amount}) {
    //  getUpi();
    //  print('vv');
  //   GetUPI.openNativeIntent(
  //   url: 'your mandate url',
  // );
    
    getGenerateInvoice(id: id, amount: amount, discount: '0', amountAfterDiscoun: amount);
  //  Get.toNamed(Routes.invoice,arguments: {'id':id,'amount':amount});
  }

  void paymentGate() {
    print(upiAppsListAndroid);
    Get.bottomSheet(
      Payment(upiAppsListAndroid: upiAppsListAndroid,),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  void drawerActions(String goToScreen) async {
    switch (goToScreen) {
      case 'Tarrif':
        break;
      case 'Chips':
      Get.dialog( DialogBox(title: 'Chips', child: Chips(
        amount: chipAmount, 
        totalAmount: '1', callBack: (amount,discount,amountAfterDiscount) {
          getGenerateInvoice(id: 100, amount: amount, discount: discount, amountAfterDiscoun: amountAfterDiscount);
         },)));
        break;
      case 'Contact':
        break;
      case 'logout':
        logout();
        break;
    }
  }

    void logout() async {
    try {
      var param = {
        'token' : Helper.token,
         'ts': Helper.ts,
        'gId': 1,

      };
      logoutRes =
          await ApiCallRepo.instance.logout(param);
      if (logoutRes?['respCode'] == 100) {
      //   Helper.token = '';
      //   Helper.userId = '';
      //   Helper.customerId = '';
      //   Helper.usertoken = '';
      //  Get.offAllNamed(Routes.loginUser);
        update();
      } else {
        Helper.toast('Something when wrong.');
      }
      update();
    } catch (e) {
      rethrow;
    } finally {}
  }

  void getGenerateInvoice({required int id,required String amount,required String discount, required String amountAfterDiscoun }) async {
    try {
      var param = {
         "amount": amount,
          "discount": discount,
          "amount_after_discount": amountAfterDiscoun,
          "item_id": id,
          "item_description": "test",
          "Remarks": "test",
          ...Helper.instance.getParams()
      };
      generateInvoice = await ApiCallRepo.instance.generateInvoice(param);
      if (generateInvoice?['respCode'] == 100) {
        Get.toNamed(Routes.invoice,arguments: {'link':generateInvoice?['respData']['invoice_url'] ?? Urls.pdf});
      } else {
        Helper.toast('Something when wrong.');
      }
      update();
    } catch (e) {
      rethrow;
    } finally {}
  }

  List<UpiApp>? apps;

      Future<void> getUpi() async {
        upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
          print(value.length);
 
        }).catchError((e) {
          print(e);
          apps = [];
        });
      // if (Platform.isAndroid) {
      //     var value = await GetUPI.apps();
      //     print(value.data.length);
      //    // upiAppsListAndroid = value.data;
      // }
    }

}

class ChipsModel{
  int id;
  String title;
  String minAmount;
  String? image;
  VoidCallback? onTap;
  ChipsModel({required this.id, required this.title,required this.minAmount,this.image,this.onTap});
}
