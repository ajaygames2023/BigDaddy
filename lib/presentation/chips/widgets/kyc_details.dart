import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import '../controller.dart';
import 'kyc_ui/doc.dart';

class KycDetails extends StatelessWidget {
  const KycDetails({
    required this.controller,
    super.key});
  final ChipController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
    //  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const CasinoText(text: 'Is Digital KYC',fontWeight: FontWeight.bold,fontSize: 16,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Transform.scale(
                scale: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: RadioGroup<String>.builder(
                    fillColor: const Color.fromARGB(255, 255, 206, 60),
                  textStyle: const TextStyle(color: CasinoColors.secondary,fontSize: 18,fontWeight: FontWeight.bold),
                    direction: Axis.horizontal,
                    groupValue: controller.digitalKycGroupValue,
                    onChanged: (value) { controller.selectKycTypeMode(value ?? 'Digital');},
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
        const SizedBox(height: 20,),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Transform.scale(
            scale: 1,
            child: RadioGroup<String>.builder(
              fillColor: const Color.fromARGB(255, 255, 206, 60),
            textStyle: const TextStyle(color: CasinoColors.secondary,fontSize: 18,fontWeight: FontWeight.bold),
              direction: Axis.horizontal,
              groupValue: controller.digitalKycModeGroupValue,
              onChanged: (value) { controller.selectKycMode(value ?? 'Digital');},
              items: const ['Pan','Aadhar Card'],
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20,),
          Doc(groupValue: controller.digitalKycModeGroupValue,
            panImage: controller.panImage,
            aadharBackImage: controller.aadharBackImage,
            aadharFrontImage: controller.aadharFrontImage,
            callBack: (typeImage) { 
              controller.chooseWhichImage(typeImage);
            controller.update();}),
          const SizedBox(height: 20,),
          Center(
            child: CasinoButton(
              width: 200,
              height: 30,
              title: 'Upload',
              onTap: (){
                controller.onVerify();
              },
            ),
          ),
          const SizedBox(height: 20,),
    
      ],
    );
  }
}