
import 'package:casino/presentation/splash/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Splash extends GetView<SplashController> {
  const Splash({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: GetBuilder<SplashController>(
            builder: (context) {
              return Material(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    image: DecorationImage(
                      image: AssetImage("assets/images/mg_splash.jpg"),
                      fit: BoxFit.contain,
                    ),
                  ),
                            ));
            }
          ));
  }
}