import 'dart:io';

import 'package:casino/domain/domain/api_constants.dart';
import 'package:casino/domain/repositories/api_calls.dart';
import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/dialog.dart';
import 'package:casino/global_widgets/pg.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/presentation/home/widgets/payment_dialog/index.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_upi/get_upi.dart';

import '../../config/router/routes.dart';
import '../../domain/models/invoice/invoice_data.dart';
import '../../domain/models/invoice/invoice_generate.dart';
import '../../domain/models/kycdata_status/index.dart';
import '../../utils/helper/helper.dart';
import '../chips/controller.dart';
import 'widgets/chip_dialog.dart';
import 'widgets/packages.dart';
import 'widgets/welcome_page.dart';

class ItemsController extends GetxController {

  bool isLoading = true;
  bool isPackage = false;
  Map<String, dynamic>? logoutRes;
 // Map<String, dynamic>? generateInvoice;
  GenerateInvoiceModel? invoiceData;
  Map<String,dynamic>? kycStatus;
  List<KycDataStatus>? kycDataStatus;
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
                child: CasinoText(text: title ?? '',color: CasinoColors.secondary)),
            )),
          const  SizedBox(width: 10,),
          SizedBox(
            width: 100,
            child: Align(
              alignment: Alignment.centerRight,
              child: CasinoText(text: 'Rs $amount',color: CasinoColors.secondary))),
        ],
      ),
    );
  }

  Widget getSheetWidget({String? packageTitle,String? packageAmount,required VoidCallback onTap}) {
    return Container(
      height: 500,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const CasinoText(text: 'Package Details',color: CasinoColors.secondary,fontWeight: FontWeight.bold,fontSize: 18,),
          // const SizedBox(height: 10,),
          getSelectedPackage(title: packageTitle,amount: packageAmount ?? '0'),
          getSelectedPackage(title: 'Less Discount',amount: getDiscount(packageAmount??'0')),
          getSelectedPackage(title: 'Supply of Actionable Claim ',amount: getAmountBeforeDiscount(packageAmount ??'0')),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: getSelectedPackage(title: 'SGST (14%) :', amount: getGST(packageAmount??'0'),align: Alignment.centerRight),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: getSelectedPackage(title: 'CGST (14%) :', amount: getGST(packageAmount??'0'),align: Alignment.centerRight),
          ),
          const Divider(color: CasinoColors.white,),
           Padding(
             padding: const EdgeInsets.only(left: 0),
             child: getSelectedPackage(title: 'Total Payable Amount :', amount: num.parse(packageAmount ?? '0').toStringAsFixed(2),align: Alignment.centerRight),
           ),
          const SizedBox(height: 20,),
             Align(
            alignment: Alignment.center,
            child: CasinoButton(title: 'Pay Now',height: 40,fontSize: 20,onTap: onTap,)),
        ],
      ),
    );
  }

  String getGST(String amount) {
    return ((num.parse(amount) - num.parse(getDiscount(amount))) * 0.14).toStringAsFixed(2);
  }

  String getDiscount(String amount) {
    return (num.parse(amount) * 0.21875).toStringAsFixed(2);
  }

  String getAmountBeforeDiscount(String amount) {
    return (num.parse(amount) - num.parse(getDiscount(amount))).toStringAsFixed(2);
  }

  void onBook({required int id,required String amount,required String title}) async{
    
    Get.dialog(DialogBox(title: 'Package Details', child: getSheetWidget(
      packageTitle: title,
      packageAmount: amount,
      onTap: () {
      Get.back();
      openPaymentMode(amount: amount, name: Helper.customerName, userId: Helper.customerId, isKyc: true);
    //  getPaymentMethod(id: id,amount: amount);
    },)
    ));
    // await getGenerateInvoice(id: id, amount: amount, discount: '0', amountAfterDiscoun: amount,isPackage: false).then((_) async {
    //  // await getUpi();
    // //  Helper.openBottomSheet(child: (p0) => getSheetWidget(
    // //   packageTitle: title,
    // //   packageAmount: amount,
    // //   onTap: () {
    // //   Get.back();
    // //   getPaymentMethod(id: id,amount: amount);
    // // },));


    // });
  //  getGenerateInvoice(id: id, amount: amount, discount: '0', amountAfterDiscoun: amount);
  //  Get.toNamed(Routes.invoice,arguments: {'id':id,'amount':amount});
  }

  // void getPaymentMethod({required int id,required String amount}) {
  //   Helper.openBottomSheet(child: (p0) => Payment(upiAppsListAndroid: upiAppsListAndroid,onSuccess: (){
  //     Get.toNamed(Routes.invoice,arguments: {'link': invoiceData!.invoiceUrl ?? Urls.pdf});
  //   },),);
  // }

  // void drawerActions(String goToScreen) async {
  //   switch (goToScreen) {
  //     case 'Tarrif':
  //       break;
  //     case 'Chips':
  //     Get.dialog( DialogBox(title: 'Chips', child: Chips(
  //       amount: chipAmount, 
  //       totalAmount: '1', callBack: (amount,discount,amountAfterDiscount) {
  //         getGenerateInvoice(id: 100, amount: amount, discount: discount, amountAfterDiscoun: amountAfterDiscount);
  //        },)));
  //       break;
  //     case 'Contact':
  //       break;
  //     case 'logout':
  //       logout();
  //       break;
  //   }
  // }

    void logout() async {
    try {
      var param = {
        'token' : Helper.usertoken,
        'ts': Helper.ts,
        'gId': 1,

      };
      logoutRes =
          await ApiCallRepo.instance.logout(param);
      if (logoutRes?['respCode'] == 100) {
        Helper.token = '';
        Helper.userId = '';
        Helper.customerId = '';
        Helper.usertoken = '';
        Helper.userName = '';
        Helper.roleId = 3;
        Get.offAllNamed(Routes.loginUser);
        update();
      } else {
        Helper.toast('Something when wrong.');
      }
      update();
    } catch (e) {
      rethrow;
    } finally {}
  }

  getGenerateInvoice({
    String? txnNo,
    String? paymentType,
    required String paymentMode,
    String? panNo,
    required int id,required String amount,required String discount, required String amountAfterDiscoun,}) async {
    try {
      var param = {
        "customer_id":Helper.customerId,
        "customer_name":Helper.customerName,
        "customer_mobno":Helper.customerMobileNbr,
        "panNo" : panNo,
        "paymentMode" : paymentMode,
        "paymentType" : paymentType,
        'txnNo' : txnNo,
        "amount": amount,
        "discount": discount,
        "amount_after_discount": amountAfterDiscoun,
        "item_id": id,
        "item_description": "Face Value of Chips",
        "Remarks": "test",
        "Userid":Helper.userId,
        ...Helper.instance.getParams()
      };
      invoiceData = await ApiCallRepo.instance.generateInvoice(param);
      if (invoiceData!= null) {
        Get.back();
        final result = Get.toNamed(Routes.invoice,arguments: {'link':invoiceData!.invoiceUrl});
        if(result != null) {
          ChipController controller = Get.put(ChipController());
          controller.clearData();
        }
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
        upiAppsListAndroid = value.data;
    }
  }

    Widget getProductItems({required ItemsController controller}) {
      if(isPackage) {
        return Packages(controller: controller,);
      }
      return WelcomePage(controller: controller);
    }

    void getKycStatus() async {
      try {
        final params = <String, dynamic>{
        "email": 'userId.text',
      };
        kycStatus = await ApiCallRepo.instance.getKycStatus(params);
        if (kycStatus?['respCode'] == 100) {
          kycDataStatus?.addAll(kycStatus?['respCode']);
        } else {
          Helper.toast(kycStatus?['message']);
        }
      } catch (e) {
        rethrow;
      } finally {
        loadingData();
      }
    }

    void getChipsDialog() {
      Get.toNamed(Routes.chip);
      //  Get.dialog( DialogBox(title: 'Chips', child: Chips(
      //   amount: chipAmount, 
      //   totalAmount: '1', callBack: (name,useId,isKyc,amount,discount,amountAfterDiscount) {
      //     Get.back();
      //     openPaymentMode(name: name,userId: useId,isKyc: isKyc,amount: amount,discount: discount,amountAfterDiscount: amountAfterDiscount);
      //    },)));
    }

    void openPaymentMode({
      required String name,
      required String userId,
      required bool isKyc,
      required String amount,
      String? discount,
      String? amountAfterDiscount}) {
      Get.dialog( DialogBox(title: 'Payment Mode', child: PaymentDialog(amount: amount,isKyc: isKyc,callBack: (paymentMode, paymentType, txnNo, panNo) {
        getGenerateInvoice(id: 1, amount:amount, discount: discount ?? '0', amountAfterDiscoun:amountAfterDiscount ?? '0', paymentMode: paymentMode??'',panNo: panNo,paymentType: paymentType,txnNo: txnNo);
      },)));
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
