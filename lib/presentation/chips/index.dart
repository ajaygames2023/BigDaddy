import 'package:casino/main.dart';
import 'package:casino/presentation/chips/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';

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
      body: GetBuilder<ChipController>(builder:(context1){
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
              if(controller.isDisableUserBtn) Padding(
                 padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
                 child: Column(
                  children: [
                    const SizedBox(height: 50,),             
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CasinoText(text: 'User Details',fontSize: 20,fontWeight: FontWeight.bold,),
                            const SizedBox(height: 20,),
                            (controller.myProfile != null) ? CasinoText(text: 'Name : ${controller.myProfile!.screenName}') : const SizedBox.shrink(),
                            const SizedBox(height: 20,),
                            (controller.myProfile != null) ? CasinoText(text: 'Pan Verifed : ${controller.myProfile!.isPanCardVerified}') : const SizedBox.shrink(),
                            const SizedBox(height: 20,),
                            (controller.myProfile != null) ? CasinoText(text: 'Aadhar Verifed : ${controller.myProfile!.isAadharCardVerified}') : const SizedBox.shrink(),
                          ],
                        ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CasinoText(text: 'Chip Value Details',fontSize: 20,fontWeight: FontWeight.bold,),
                              const SizedBox(height: 20,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
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
                              const SizedBox(height: 30),              
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const CasinoText(text: 'IsDiscount',fontWeight: FontWeight.bold,),
                                    const SizedBox(width: 20,),
                                   CupertinoSwitch(
                                    activeColor: CasinoColors.primary,
                                    value: controller.isDiscount,
                                    onChanged: (value) {
                                      //  controller.discountValue.text = '0';
                                        controller.isDiscount = value;
                                        // controller.lessDiscount = controller.getDiscount1(controller.valueAmount, discountValue: '0', discountType: controller.discountGroupValue,isDiscount: controller.isDiscount);
                                        // controller.getFaceValue(controller.valueAmount);
                                        controller.update();
                                        // getDiscountAmount(valueAmount);
                                        // getFaceValue(valueAmount);
                                    },
                                ),
                                  ],
                                ),
                              ),
                              // const SizedBox(height: 20), 
                              // if(controller.isDiscount)Column(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Row(
                              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         SizedBox(
                              //           width: MediaQuery.of(context).size.width * 0.3,
                              //           child: Transform.scale(
                              //               scale: 1,
                              //               child: Padding(
                              //                 padding: const EdgeInsets.only(left: 30),
                              //                 child: RadioGroup<String>.builder(
                              //                   fillColor: const Color.fromARGB(255, 255, 206, 60),
                              //                 textStyle: const TextStyle(color: CasinoColors.secondary,fontSize: 14),
                              //                   direction: Axis.horizontal,
                              //                   groupValue: controller.discountGroupValue,
                              //                   onChanged: (value) { controller.selectDiscountModeType(value ?? 'Percentage');},
                              //                   items: const ['Fixed','Percentage'],
                              //                   itemBuilder: (item) => RadioButtonBuilder(
                              //                     item,
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //             ),
                              //             const SizedBox(width: 20,),
                              //           SizedBox(
                              //             width: 150,
                              //             height: 50,
                              //             child: TextFormField(
                              //             controller: controller.discountValue,
                              //             inputFormatters:[
                              //               LengthLimitingTextInputFormatter(6),
                              //             ],
                              //             keyboardType: TextInputType.number,
                              //               decoration: const InputDecoration(
                              //                 border: OutlineInputBorder(),
                              //                 focusedBorder: OutlineInputBorder(
                              //                   borderSide: BorderSide(color: CasinoColors.primary)
                              //                 ),
                              //                 focusColor: Colors.black,
                              //                 labelStyle: TextStyle(color: CasinoColors.secondary)
                              //               ),
                              //               onChanged: (value){
                              //                 if(value.isNotEmpty) {
                              //                   controller.lessDiscount = controller.getDiscount1(controller.valueAmount, discountValue: value, discountType: controller.discountGroupValue,isDiscount: controller.isDiscount);
                              //                   controller.getFaceValue(controller.valueAmount);
                              //                   controller.update();
                              //                   } else {
                              //                   controller.lessDiscount = controller.getDiscount1(controller.valueAmount, discountValue: '0', discountType: controller.discountGroupValue,isDiscount: controller.isDiscount);
                              //                   controller.getFaceValue(controller.valueAmount);
                              //                   controller.update();
                              //                   }
                              //               },
                              //             ),
                              //           ),
                                      
                              //       ],
                              //     ),
                              //         const SizedBox(height: 20,),
                              //         SizedBox(
                              //          // width: MediaQuery.of(context).size.width * 0.3,
                              //           child: Row(
                              //             mainAxisAlignment: MainAxisAlignment.start,
                              //             children: [
                              //               const CasinoText(text: 'Discount Type : ',fontWeight: FontWeight.bold,),
                              //               const SizedBox(width: 20,),
                              //               DropdownButton(
                              //                 value: controller.discountType,
                              //                 items: controller.discountListType.map((String value) {
                              //                   return DropdownMenuItem<String>(
                              //                     value: value,
                              //                     child: Text(value),
                              //                   );
                              //                 }).toList(), onChanged: (value){
                              //                   controller.discountType = value ?? 'Dealer';
                              //                   controller.update();
                              //                 })
                              //             ],
                              //           ),
                              //         ),
               
                              //   ],
                              // ),
                              // const SizedBox(height: 20,),
                              SizedBox(
                                height: 10,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: const Divider(
                                  thickness: 2,
                                  color: CasinoColors.black,
                                ),
                              ),
                              const SizedBox(height: 20,),
                              controller.getRowWidget(title: 'Chips Face Value',amount: controller.valueAmount.toString()),
                              const SizedBox(height: 10,),
                              controller.getRowWidget(title: 'Less Discount',amount: controller.getDiscount(controller.valueAmount.toString())),
                              const SizedBox(height: 10,),
                              controller.getRowWidget(title: 'Chips Worth',amount: controller.faceValue),
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
                    const SizedBox(height: 30,),
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
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: 50,
                        enabled: controller.isDisableUserBtn,
                        title: 'Submit',),
                    )
               
                  ],
                             ),
               ),             
            ]),
          ),
        );
    
      }),
    );
  }
}