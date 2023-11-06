import 'package:casino/presentation/chips/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../global_widgets/buttons.dart';
import '../../global_widgets/text.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helper/helper.dart';

class Chips extends GetView<ChipController> {
  const Chips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CasinoColors.secondary,
        leading: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.arrow_back_ios,color: CasinoColors.primary,)),
        title: const CasinoText(text: 'Chips',color: Color.fromARGB(255, 250, 198, 65),fontWeight: FontWeight.bold,),
         ),
      body: GetBuilder<ChipController>(builder:(context){
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 85,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                        controller: controller.mobileNbr,
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(10),
                        ],
                        keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: CasinoColors.primary)
                            ),
                            enabled: !controller.isOTPField,
                            focusColor: Colors.black,
                            labelText: 'Enter Mobile Number',
                            labelStyle: const TextStyle(color: CasinoColors.secondary)
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                      if(controller.isOTPField) SizedBox(
                        width: 150,
                        height: 85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 150,
                              height: 50,
                              child: TextFormField(
                              controller: controller.otp,
                              inputFormatters:[
                                LengthLimitingTextInputFormatter(6),
                              ],
                              keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: CasinoColors.primary)
                                  ),
                                  enabled: !controller.isNameField,
                                  focusColor: Colors.black,
                                  labelText: 'Enter OTP',
                                  labelStyle: const TextStyle(color: CasinoColors.secondary)
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                              child: CasinoText(text: controller.otpStatus,fontSize: 10,color: controller.getOtpStatusColor(),align: TextAlign.start,)),
                            if(controller.isResendOTP)GestureDetector(
                              onTap: (){
                                controller.signInOtp();
                              },
                              child: const SizedBox(
                                height: 20,
                                child: Padding(
                                  padding: EdgeInsets.all(0.0),
                                  child: CasinoText(text: 'Resend',fontSize: 10,color: Colors.green,align: TextAlign.start,),
                                )),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 20,),
                      if(controller.isNameField) SizedBox(
                        width: 200,
                        height: 50,
                        child: TextFormField(
                        controller: controller.name,
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(20),
                        ],
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: CasinoColors.primary)
                          ),
                          enabled: !controller.isDisableUserBtn,
                          focusColor: Colors.black,
                          labelText: 'Enter Name',
                          labelStyle: const TextStyle(color: CasinoColors.secondary)
                        ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                  
                        ],
                      ),           
                      CasinoButton(
                        height: 50,
                        enabled: !controller.isDisableUserBtn,
                        title: controller.btnTitle,
                        onTap: () {

                          if(controller.isDisableUserBtn) {

                          } else {
                          if(controller.mobileNbr.text.isNotEmpty){
                            if(controller.btnTitle == 'Submit') {
                              if(controller.name.text.isNotEmpty) {
                                controller.updateProfileData();
                              } else {
                                Helper.toast('Enter your name');
                              }
                            } else if(controller.btnTitle == 'Verify') {
                              controller.login();
                            } else {
                              controller.getKycStatus();
                            }
                            
                          } else {
                             Helper.toast('Please Enter Mobile number');
                          }

                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              if(controller.isDisableUserBtn) Column(
                children: [
                  const SizedBox(height: 50,),             
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (controller.myProfile != null) ? CasinoText(text: 'Name : ${controller.myProfile!.screenName}') : const SizedBox.shrink(),
                          (controller.myProfile != null) ? CasinoText(text: 'Pan Verifed : ${controller.myProfile!.isPanCardVerified}') : const SizedBox.shrink(),
                          (controller.myProfile != null) ? CasinoText(text: 'Aadhar Verifed : ${controller.myProfile!.isAadharCardVerified}') : const SizedBox.shrink(),
                        ],
                      ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: TextFormField(
                            controller: controller.amount,
                            inputFormatters:[
                              LengthLimitingTextInputFormatter(7),
                            ],
                            onChanged: (value) {
                                if(value != '') {
                                  controller.valueAmount = value;
                                  controller.getFaceValue(controller.valueAmount);
                                } else {
                                  controller.valueAmount = '0';
                                  controller.getFaceValue(controller.valueAmount);
                                }
                                controller.update();
                            },
                            keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: CasinoColors.primary)
                                ),
                                focusColor: Colors.black,
                              // icon: Icon(Icons.person),
                                labelText: 'Enter Amount',
                                labelStyle: TextStyle(color: CasinoColors.secondary)
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
                              value: controller.isDiscount,
                              onChanged: (value) {
                                  controller.isDiscount = value;
                                  controller.update();
                                  // getDiscountAmount(valueAmount);
                                  // getFaceValue(valueAmount);
                              },
                          ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          controller.getRowWidget(title: 'Chips Face Value',amount: controller.faceValue),
                          const SizedBox(height: 10,),
                          controller.getRowWidget(title: 'Less Discount',amount: controller.getDiscount(controller.valueAmount)),
                          const SizedBox(height: 10,),
                          controller.getRowWidget(title: 'Chips Worth',amount: controller.getAmountBeforeDiscount(controller.valueAmount)),
                          const SizedBox(height: 10,),
                          controller.getRowWidget(title: 'SGST(14%)',amount: controller.getGST(controller.valueAmount)),
                          const SizedBox(height: 10,),
                          controller.getRowWidget(title: 'CGST(14%)',amount: controller.getGST(controller.valueAmount)),
                          const SizedBox(height: 10,),
                          controller.getRowWidget(title: 'Total Amount',amount: controller.valueAmount.toString()),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Center(
                    child: CasinoButton(
                      onTap:() {
                        if(controller.mobileNbr.text.isNotEmpty) {
                          if(controller.amount.text.isNotEmpty) {
                            controller.generateChipInvoice();
                          // widget.callBack(userName,userId,(userKycStatus =='APPROVE'),valueAmount,discountAmount,totalAmount);
                          } else {
                            Helper.toast('Please enter amount');
                          }
                        } else {
                          Helper.toast('Please enter mobile number');
                        }
                        },
                      width: 100,
                      enabled: controller.isDisableUserBtn,
                      title: 'Submit',),
                  )

                ],
              ),             
            ]),
          ),
        );
    
      }),
    );
  }
}