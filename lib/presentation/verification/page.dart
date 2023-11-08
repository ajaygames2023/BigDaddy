import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/presentation/verification/controller.dart';
import 'package:casino/presentation/verification/widgets/get_verify_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global_widgets/camera_macos.dart';
import '../../global_widgets/radio.dart';
import '../../utils/constants/colors.dart';
import 'widgets/documents.dart';

class Verification extends GetView<VerificationController> {
  const Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios,color: CasinoColors.primary,)),
        backgroundColor:  CasinoColors.secondary,
        title: const CasinoText(text: 'KYC Verification',color: CasinoColors.primary,fontWeight: FontWeight.bold,),
         ),
      body: SafeArea(
        child: GetBuilder<VerificationController>(
          builder: (context) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: CasinoColors.secondary,
                          image: DecorationImage(image: AssetImage('assets/images/background.jpg'),fit: BoxFit.fitHeight,opacity: 0.3)
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              // const CasinoText(text: 'Please Upload your aadhar-card or pan-card',fontSize: 16,color: Colors.white,fontWeight: FontWeight.w400,),
                               const SizedBox(height: 80,),
                              RadioButtons(groupValue: controller.groupValue, callBack: (String value) {controller.getDocumentType(value); },),
                              const SizedBox(height: 20,),
                              (controller.aadharStatus == 'APPROVE' || controller.aadharStatus == 'APPROVE') ? controller.getImage():
                              Documents(groupValue: controller.groupValue,
                                panImage: controller.panImage,
                                aadharBackImage: controller.aadharBackImage,
                                aadharFrontImage: controller.aadharFrontImage,
                                callBack: (typeImage) { controller.chooseImage(typeImage);
                                controller.update();}),
                              const SizedBox(height: 50,),
                              // (controller.groupValue != 'PAN')?VerifyDocDetails(
                              //   formField: controller.aadharNo, 
                              //   hint: 'Enter aadhar number',
                              //   enabled: !controller.isAadharVerified,
                              //   label: 'Enter aadhar number',) :
                              //   VerifyDocDetails(
                              //   formField: controller.panNo, 
                              //   label: 'Enter pan number',
                              //   enabled: !controller.isPanVerified,
                              //   hint: 'Enter pan number',
                              //   ),
                                
                            if(controller.panStatus == '' || controller.aadharStatus =='') CasinoButton(
                                  radius: 30,
                                  width: 200,
                                  height: 50,
                                  onTap: () => controller.verifyDoc(),
                                  title: 'Upload',),
                                  const SizedBox(height: 30,),
                                  
                            ],
                          ),
                        ),
                      ),
                    ),
                    if(controller.isNext)
                     Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CasinoButton(
                          radius: 30,
                          width: 200,
                          height: 50,
                          onTap: () {
                            controller.onNext();
                          },
                          title: 'Next',),
                        ),
                      ),
                    ),
                  ],
                ),
                if(!controller.isLoading) Center(child: Image.asset(
                  "assets/images/loader.gif",
                  height: 125.0,
                  width: 125.0,
                ),),
              ],
            );
          }
        ),
      ),
    );
  }
}