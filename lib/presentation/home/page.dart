import 'package:casino/global_widgets/text.dart';
import 'package:casino/presentation/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/drawer.dart';
import 'widgets/tariffs_card.dart';

class Items extends GetView<ItemsController> {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const CasinoText(text: 'Our Packages',color: Color.fromARGB(255, 250, 198, 65),fontWeight: FontWeight.bold,),
         ),
         drawer: DrawerWidget(controller: controller,),
        body: SafeArea(
          child: GetBuilder<ItemsController>(
            builder: (context) {
              return Container(
                padding: const EdgeInsets.only(top: 5),
                color: Colors.black,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CasinoText(text: '(Above 21 Packages)',fontWeight: FontWeight.w600,color: Colors.white,fontSize: 20,),
                      ),
                      SizedBox(
                        height: 500,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.chipsList.length,
                          itemBuilder: (context,index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                controller.selectList('Item $index');
                              },
                              child: TariffsCard(
                                title: controller.chipsList[index].title, 
                                amount: controller.chipsList[index].minAmount,
                                image: controller.chipsList[index].image,
                                 onTap: () {controller.onBook(id: controller.chipsList[index].id, amount: controller.chipsList[index].minAmount,);},)),
                          );
                        }),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: CasinoText(text: '(Below 21 Packages)',fontWeight: FontWeight.w600,color: Colors.white,fontSize: 20,),
                      ),
                      SizedBox(
                        height: 700,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.chipsList.length,
                          itemBuilder: (context,index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                controller.selectList('Item $index');
                              },
                              child: TariffsCard(
                                title: controller.chipsList[index].title, 
                                amount: controller.chipsList[index].minAmount,
                                image: controller.chipsList[index].image,
                                onTap: () {controller.onBook(id: controller.chipsList[index].id, amount: controller.chipsList[index].minAmount,);})),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            }
          )),
     );
  }
}