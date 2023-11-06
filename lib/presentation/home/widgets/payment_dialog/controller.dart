import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/helper/helper.dart';

class PaymentDialogController extends GetxController{

  bool isLoading = false;

  bool switchValue = false;

  String paymentModeGroupValue = 'Digital';
  String paymentTypeGroupValue = 'UPI';
  TextEditingController txnNo = TextEditingController();
  TextEditingController panNo = TextEditingController();
  

  toggleIsLoading(){
    isLoading = !isLoading;
    update();
  }

  selectPaymentMode(String val){
    paymentModeGroupValue = val;
    update();
  }
  selectPaymentModeType(String val){
    paymentTypeGroupValue = val;
    update();
  }

  void onTapGenerateInvoice({required String groupValue,required Function(String? paymentMode,String? paymentType,String? txnNo,String? panNo) callBack,required String amount}) {
    if(groupValue == 'Digital') {
      if(txnNo.text.isNotEmpty) {
        callBack(paymentModeGroupValue,paymentTypeGroupValue,txnNo.text,panNo.text);
      } else {
        Helper.toast('Please enter transaction id');
      }
    } else {
      if(num.parse(amount) >= 200000 ) {
        if(panNo.text.isNotEmpty) {
        callBack(paymentModeGroupValue,paymentTypeGroupValue,txnNo.text,panNo.text);
        } else {
          Helper.toast('Please enter pan number');
        }
      } else {
        callBack(paymentModeGroupValue,paymentTypeGroupValue,txnNo.text,panNo.text);
      }
    }
  }

}