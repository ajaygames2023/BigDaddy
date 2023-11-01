import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

}