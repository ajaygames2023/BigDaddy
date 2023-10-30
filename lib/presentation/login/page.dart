
import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../config/router/routes.dart';
import '../../utils/constants/colors.dart';
import 'controller.dart';
import 'widgets/fade_animation.dart';
import 'widgets/otp_ui.dart';

class Login extends GetView<LoginController> {
  const Login({super.key});
  Widget spacer(){
    return const SizedBox(height: 20,);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: CasinoColors.secondary,
                  child: SizedBox(
                    width: 600,
                    child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 60,
                                decoration: const BoxDecoration(
                                  color: Colors.black
                                  // gradient: LinearGradient(colors: [
                                  //   Color.fromARGB(255, 25, 23, 23),
                                  //   Color.fromARGB(255, 54, 53, 53),
                                  //   Color.fromARGB(255, 25, 23, 23),
                                  // ])
                                ),
                                child: const Center(
                                  child: Text("Customer Onboarding", style: TextStyle(color: CasinoColors.primary, fontSize: 20, fontWeight: FontWeight.bold),),
                                ),
                              ),
                              Container(
                                height: 400,
                                width: 600,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/background.jpg',),
                                    fit: BoxFit.fill
                                  )
                                ),
                              ),
                              const SizedBox(height: 40,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: <Widget>[
                                    FadeAnimation(1.8, Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: CasinoColors.primary,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromRGBO(223, 218, 122, 0.2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10)
                                          )
                                        ]
                                      ),
                                      child: Container(
                                        width: 600,
                                        height: 50,
                                        padding: const EdgeInsets.all(4.0),
                                        child: TextField(
                                          controller: controller.phoneController,
                                          keyboardType: TextInputType.phone,
                                          cursorColor: Colors.black,
                                          style: const TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                          inputFormatters:[
                                            LengthLimitingTextInputFormatter(10),
                                          ],
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Enter Phone number",
                                            hintStyle: TextStyle(color: CasinoColors.secondary,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )),
                                    const SizedBox(height: 20,),
                                    (controller.isOTP) ? SizedBox(
                                      width: 600,
                                      child: Column(
                                        children: [
                                        const Align(
                                        alignment: Alignment.centerLeft,
                                        child: CasinoText(text: 'Enter Otp',color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500,)),
                                      Container(
                                        width: 600,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: CasinoColors.primary,
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        padding: const EdgeInsets.all(4.0),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: OTPUI(pinEditingController: controller.pinEditingController,),
                                        )
                                      ),
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: CasinoText(text: 'Resend',color: Colors.white,fontSize: 16,fontWeight: FontWeight.w500,)),
                                      
                                        ],
                                      ),
                                    ) : const SizedBox.shrink(),
                  
                                    const SizedBox(height: 40,),
                                    
                                    CasinoButton(
                                      height: 50,
                                      width: 200,
                                      title: !(controller.isOTP) ? 'Submit' : 'Next',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      onTap: () async {
                                        if(controller.isOTP == true) {
                                          controller.login();
                                        } else {
                                          controller.signInOtp();
                                        }
                                      },
                                  
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  ),
                ),
                if(!controller.isLoading) Center(child: Image.asset(
                            "assets/images/loader.gif",
                            height: 125.0,
                            width: 125.0,
                          ),),
              ],
            ),
          )      );
      }
    );
  }
}