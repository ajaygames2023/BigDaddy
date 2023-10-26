import 'dart:io';

import 'package:casino/domain/domain/api_constants.dart';
import 'package:casino/domain/repositories/api_calls.dart';
import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/dialog.dart';
import 'package:casino/global_widgets/pg.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_upi/get_upi.dart';

import '../../config/router/routes.dart';
import '../../domain/models/invoice/invoice_data.dart';
import '../../domain/models/invoice/invoice_generate.dart';
import '../../utils/helper/helper.dart';
import 'widgets/chip_dialog.dart';

class ItemsController extends GetxController {

  bool isLoading = true;
  Map<String, dynamic>? logoutRes;
 // Map<String, dynamic>? generateInvoice;
  GenerateInvoiceModel? invoiceData;
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

  Widget getSelectedPackage({String? title,required String amount,Alignment? align}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: Align(
                alignment: align ?? Alignment.centerLeft,
                child: CasinoText(text: title ?? '',color: CasinoColors.white)),
            )),
          const  SizedBox(width: 10,),
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: CasinoText(text: 'Rs $amount',color: CasinoColors.white))),
        ],
      ),
    );
  }

  Widget getSheetWidget({String? packageTitle,String? packageAmount,required VoidCallback onTap}) {
    InvoiceData data = invoiceData?.invoiceData! ?? InvoiceData();
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CasinoText(text: 'Package Details',color: CasinoColors.white,fontWeight: FontWeight.bold,fontSize: 18,),
          const SizedBox(height: 10,),
          getSelectedPackage(title: data.itemDescription,amount: data.price ?? '0'),
          getSelectedPackage(title: 'Less Discount',amount: data.discount!.toStringAsFixed(2)),
          getSelectedPackage(title: 'Supply of Actionable Claim ',amount: data.amountAfterDiscount!.toStringAsFixed(2)),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: getSelectedPackage(title: 'SGST (14%) :', amount: data.sGSTAmount!.toStringAsFixed(2),align: Alignment.centerRight),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: getSelectedPackage(title: 'CGST (14%) :', amount: data.cGSTAmount!.toStringAsFixed(2),align: Alignment.centerRight),
          ),
          const Divider(color: CasinoColors.white,),
           Padding(
             padding: const EdgeInsets.only(left: 0),
             child: getSelectedPackage(title: 'Total Payable Amount :', amount: num.parse(data.totalAmount!).toStringAsFixed(2),align: Alignment.centerRight),
           ),
          const SizedBox(height: 20,),
             Align(
            alignment: Alignment.center,
            child: CasinoButton(title: 'Pay Now',height: 40,fontSize: 20,onTap: onTap,)),

        ],
      ),
    );
  }

  void onBook({required int id,required String amount,required String title}) async{
    await getGenerateInvoice(id: id, amount: amount, discount: '0', amountAfterDiscoun: amount).then((_) async {
      await getUpi();
     Helper.openBottomSheet(child: (p0) => getSheetWidget(
      packageTitle: title,
      packageAmount: amount,
      onTap: () {
      Get.back();
      getPaymentMethod(id: id,amount: amount);
    },));

    });
  //  getGenerateInvoice(id: id, amount: amount, discount: '0', amountAfterDiscoun: amount);
  //  Get.toNamed(Routes.invoice,arguments: {'id':id,'amount':amount});
  }

  void getPaymentMethod({required int id,required String amount}) {
    Helper.openBottomSheet(child: (p0) => Payment(upiAppsListAndroid: upiAppsListAndroid,onSuccess: (){
      Get.toNamed(Routes.invoice,arguments: {'link': invoiceData!.invoiceUrl ?? Urls.pdf});
    },),);
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

  getGenerateInvoice({required int id,required String amount,required String discount, required String amountAfterDiscoun }) async {
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
      invoiceData = await ApiCallRepo.instance.generateInvoice(param);
      if (invoiceData!= null) {
       // Get.toNamed(Routes.invoice,arguments: {'link':generateInvoice?['respData']['invoice_url'] ?? Urls.pdf});
      } else {
        Helper.toast('Something when wrong.');
      }
      update();
    } catch (e) {
      rethrow;
    } finally {}
  }

      Future<void> getUpi() async {
        // upiIndia.getAllUpiApps(mandatoryTransactionId: true).then((value) {
        //   print('abc');
        //   print(value);
        //   apps = value;
        //   update();
        //   print(value.length);
 
        // }).catchError((e) {
        //   print(e);
        //   apps = [];
        // });
      if (Platform.isAndroid) {
          var value = await GetUPI.apps();
          print(value.data.length);
          upiAppsListAndroid = value.data;
      }
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
