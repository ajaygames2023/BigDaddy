import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../domain/models/kycdata_status/index.dart';
import '../../../domain/repositories/api_calls.dart';
import '../../../global_widgets/buttons.dart';
import '../../../global_widgets/text.dart';
import '../../../utils/helper/helper.dart';
import '../controller.dart';

class Chips extends StatefulWidget {
  const Chips({
    required this.amount,
    this.isDiscount,
    required this.totalAmount,
    required this.callBack,
    this.controller,
    super.key});
  final TextEditingController amount;
  final ItemsController? controller;
  final bool? isDiscount;
  final String totalAmount;
  final Function(String name,String userId,bool isVerified,String amount,String discount,String amountAfterDiscoun) callBack;

  @override
  State<Chips> createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
String totalAmount = '0';
String valueAmount = '0';
String discountAmount = '0';
String faceValue ='0';
String gstAmount = '0';
bool isDiscount = false ;
TextEditingController discountPercentage = TextEditingController();
TextEditingController mobileNbr= TextEditingController();
  Map<String,dynamic>? kycStatus;
  List<KycDataStatus>? kycDataStatus;
  String userName = '';
  String customerName = '';
  String userKycStatus = '';
  String userId = '';
  @override
  void initState() {
    isDiscount = widget.isDiscount ?? false;
    super.initState();
  }

  String getUserName() {
    if(kycDataStatus![0].aadharData!.status =="APPROVE") {
      return kycDataStatus![0].aadharData!.name ?? '';
    } else if(kycDataStatus![1].panData!.status =="APPROVE"){
      return kycDataStatus![1].panData!.name ?? '';
    } else {
      return '';
    }
  }

  String getKycStatusVar() {
    if(kycDataStatus![1].panData!.status =="APPROVE") {
      userId = kycDataStatus![1].panData!.userId.toString();
      return kycDataStatus![1].panData!.status ??'';
    } else if(kycDataStatus![0].aadharData!.status =="APPROVE") {
      userId = kycDataStatus![0].aadharData!.userId.toString();
      return kycDataStatus![0].aadharData!.status ?? '';
    } else {
      return 'PENDING';
    }
  }

  void getKycStatus() async {
    try {
      final params = <String, dynamic>{
      "userData": mobileNbr.text,
    };
      kycStatus = await ApiCallRepo.instance.getKycStatus(params);
      if (kycStatus?['respCode'] == 100) {
        kycDataStatus?.addAll(kycStatus?['respCode']);
        userName = getUserName();
        userKycStatus = getKycStatusVar();
        Helper.customerId = userId;
        Helper.customerName = userName;
      } else {
        Helper.toast(kycStatus?['message']);
      }
    } catch (e) {
      rethrow;
    } finally {
    }
  }

String totalAmountWithDiscount(String value,String discountPercentage) {
  if(isDiscount) {
    discountAmount = ((1/num.parse(discountPercentage))*num.parse(value)).toStringAsFixed(2);
  return (num.parse(value) - ((1/num.parse(discountPercentage))*num.parse(value))).toStringAsFixed(2);
  }
  return value;
}

String getDiscountAmount(String value) {
  if(value!= '0'){
  if(isDiscount) {
    discountAmount = ((2 * num.parse(getGST(value)))).toStringAsFixed(2);
  return discountAmount;
  }}
  return value;
}

String getFaceValue(String value){
  if(value == '') {
    return '0';
  }
  if(value != '0'){
  if(!isDiscount) {
    faceValue = (num.parse(value)-(2 * num.parse(getGST(value)))).toStringAsFixed(2);
    return faceValue;
  } else {
      faceValue = (num.parse(value)).toStringAsFixed(2);
      return faceValue;
  }}
  return value;
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

Widget getRowWidget({required String title,required String amount}) {
  return Row(
    children: [
      Expanded(child: SizedBox(
        child: Align(
          alignment: Alignment.centerRight,
          child: CasinoText(text: '$title : ')))),
      const SizedBox(width: 50,),
      SizedBox(
        child: SizedBox(child: CasinoText(text: 'Rs $amount'))),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // const Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     CasinoText(text: 'Payment mode'),
            //     CasinoText(text: 'Online'),
            //   ],
            // ),
            // const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: TextFormField(
                  controller: mobileNbr,
                  inputFormatters:[
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.black,
                      labelText: 'Enter Mobile Number',
                    ),
                  ),
                ),
                const SizedBox(width: 20,),
                CasinoButton(
                  title: 'Search',
                  onTap: () {
                    if(mobileNbr.text.isNotEmpty){
                      getKycStatus();
                    } else {
                       Helper.toast('Please Enter Mobile number');
                    }
                  },
                )
              ],
            ),
            const SizedBox(height: 20,),
            (userName != '') ? CasinoText(text: userName) : const SizedBox.shrink(),
            (userKycStatus != '') ? CasinoText(text: userKycStatus) : const SizedBox.shrink(),
            SizedBox(
                  width: 200,
                  height: 50,
                  child: TextFormField(
                  inputFormatters:[
                    LengthLimitingTextInputFormatter(7),
                  ],
                  onChanged: (value) {
                    setState(() {
                      if(value != '') {
                        valueAmount = value;
                        getFaceValue(valueAmount);
                      } else {
                        valueAmount = '0';
                        getFaceValue(valueAmount);
                      }
                    //  totalAmount = totalAmountWithDiscount(value,'0');
                    });
                  },
                  keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Colors.black,
                    // icon: Icon(Icons.person),
                      labelText: 'Enter Amount',
                    ),
                  ),
                ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    CasinoText(text: 'IsDiscount'),
                    SizedBox(width: 20,),
                    // if(isDiscount)SizedBox(
                    //   width: 150,
                    //   height: 40,
                    //   child: TextFormField(
                    //   controller:discountPercentage,
                    //   inputFormatters:[
                    //     LengthLimitingTextInputFormatter(3),
                    //   ],
                    //   onChanged: (value) {
                    //     setState(() {
                    //       discountAmount = totalAmountWithDiscount(valueAmount,value);
                    //     });
                    //   },
                    //   keyboardType: TextInputType.number,
                    //     decoration: const InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       focusColor: Colors.black,
                    //     // icon: Icon(Icons.person),
                    //       labelText: 'Discount %',
                    //     ),
                    //   ),
                    // ),

                  ],
                ), 
                CupertinoSwitch(
                activeColor: CasinoColors.primary,
                value: isDiscount,
                onChanged: (value) {
                  setState(() {
                    isDiscount = value;
                    // getDiscountAmount(valueAmount);
                    // getFaceValue(valueAmount);
                  });
                },
            ),
              ],
            ),
            const SizedBox(height: 20,),
            getRowWidget(title: 'Chips Face Value',amount: faceValue),
            const SizedBox(height: 10,),
            getRowWidget(title: 'Less Discount',amount: getDiscount(valueAmount)),
            const SizedBox(height: 10,),
            getRowWidget(title: 'Chips Worth',amount: getAmountBeforeDiscount(valueAmount)),
            const SizedBox(height: 10,),
            getRowWidget(title: 'SGST(14%)',amount: getGST(valueAmount)),
            const SizedBox(height: 10,),
            getRowWidget(title: 'CGST(14%)',amount: getGST(valueAmount)),
            const SizedBox(height: 10,),
            getRowWidget(title: 'Total Amount',amount: valueAmount.toString()),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const CasinoText(text: 'Total Amount'),
            //     CasinoText(text: totalAmount.toString()),
            //   ],
            // ),
            const SizedBox(height: 20,),
            Center(
              child: CasinoButton(
                onTap:() {
                  if(valueAmount != '') {
                    if(mobileNbr.text != '') {
                      widget.callBack(userName,userId,(userKycStatus =='APPROVE'),valueAmount,discountAmount,totalAmount);
                    } else {
                      Helper.toast('Please Enter Mobile number');
                    }
                  } else {
                    Helper.toast('Please Enter Amount');
                  }
                  },
                width: 100,
                title: 'Submit',),
            )
            
          ]),
        ),
      );

  }
}