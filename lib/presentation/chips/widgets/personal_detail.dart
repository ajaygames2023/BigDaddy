import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/presentation/chips/widgets/text_field.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

import '../../../global_widgets/text.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/helper/helper.dart';
import '../controller.dart';

class PersonaldetailChip extends StatelessWidget {
  const PersonaldetailChip({
    required this.controller,
    super.key});
  final ChipController controller;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CasinoText(text: 'User Details',fontSize: 20,fontWeight: FontWeight.bold,),
          const SizedBox(height: 20,),
            Row(
              children: [
                ChipTextField(controller : controller.mobileNbr,length: 10,labelText: 'Enter Mobile Number',
                enabled: controller.isVerificationDisabled,
                onChanged: (value) {
                  if(controller.isVerified == 'Yes') {
                  if(value.length == 10) {
                    controller.isOTPField = true;
                    controller.update();
                  }
                }},),
                const SizedBox(width: 20,),
               if(controller.isVerificationDisabled)(controller.isVerified == 'Yes') ? CasinoButton(title: 'Send OTP',
               onTap: (){
                if(controller.mobileNbr.text.length == 10) {
                  controller.isOTPField = true;
                  controller.signInOtp();
                } else {
                  Helper.toast('Please enter valid mobile number.');
                }
                  },) : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                const CasinoText(text: 'Is Verified',fontSize: 16,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Transform.scale(
                    scale: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: RadioGroup<String>.builder(
                        fillColor: const Color.fromARGB(255, 255, 206, 60),
                      textStyle: const TextStyle(color: CasinoColors.secondary,fontSize: 18),
                        direction: Axis.horizontal,
                        groupValue: controller.isVerified,
                        onChanged: (controller.isVerificationDisabled) ? (value) { controller.selectIsVerified(value ?? 'Yes');} : null,
                        items: const ['Yes','No'],
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if(controller.isOTPField) Column(
              children: [
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChipTextField(controller : controller.otp,length: 6,labelText: 'Enter OTP',enabled: controller.isVerificationDisabled,),
                        if(controller.isVerificationDisabled) GestureDetector(
                          onTap: () => controller.signInOtp,
                          child: const CasinoText(text: 'Resend',color: CasinoColors.green,)),
                      ],
                    ),
                    const SizedBox(width: 20,),
                    if(controller.isVerificationDisabled) Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: CasinoButton(title: 'Verify Otp',onTap: () { 
                        controller.login();} ,),
                    ),
                  ],
                ),
              ],
            ),
            if(controller.isNameField) Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                ChipTextField(controller : controller.name,labelText: 'Enter Name',length: 16,keyboardType: TextInputType.name,textCapitalization : TextCapitalization.words),
                const SizedBox(height: 20,),
                const CasinoText(text: 'Signature'),
                const SizedBox(height: 10,),
                DottedBorder(
                  child: GestureDetector(
                    onTap: controller.signature,
                    child: SizedBox(
                      height: 80,
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: (controller.signatureImg != null) ? Image.memory(controller.signatureImg!,fit: BoxFit.contain,) : const Center(child: CasinoText(text: 'Tap to sign'),),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}