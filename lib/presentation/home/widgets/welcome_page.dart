import 'package:casino/presentation/home/widgets/product_card.dart';
import 'package:casino/utils/helper/helper.dart';
import 'package:flutter/material.dart';

import '../controller.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({required this.controller, super.key});
  final ItemsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      color: Colors.black,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(Helper.roleId != 1) ProductCard(title: 'Packages',image: 'assets/images/package_icon.png',onTap: () {
                controller.isPackage = true;
                controller.update();              
              },),
              const SizedBox(width: 40,),
              if(Helper.roleId != 2) ProductCard(title: 'Chips',image: 'assets/images/chips_icon.png',onTap: controller.getChipsDialog,),
            ],
          )
        ),
      )
      );

  }
}