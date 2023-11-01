import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/presentation/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helper/helper.dart';

class Items extends GetView<ItemsController> {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ItemsController>(
      builder: (context) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: CasinoColors.secondary,
           appBar: AppBar(
              backgroundColor: CasinoColors.secondary,
              leading: (controller.isPackage) ? IconButton(onPressed: (){
                controller.isPackage = false;
                controller.update();
              }, icon: const Icon(Icons.arrow_back_ios)):IconButton(onPressed: (){controller.logout();}, icon: const Icon(Icons.logout,color: Color.fromARGB(255, 250, 198, 65),)),
              title: CasinoText(text: 'Welcome   ${Helper.userName} / ${Helper.userId}',color: const Color.fromARGB(255, 250, 198, 65),fontWeight: FontWeight.bold,fontSize: 20,),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Center(child: CasinoText(text: 'Bussiness Date : ${Helper.bussinessDate}',color: Color.fromARGB(255, 250, 198, 65),fontWeight: FontWeight.bold,fontSize: 20,)),
                ),
              ],
               ),
            //   drawer: DrawerWidget(controller: controller,),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: controller.getProductItems(controller: controller),
              ),
           ),
        );
      }
    );
  }
}