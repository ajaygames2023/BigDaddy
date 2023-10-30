import 'package:flutter/material.dart';
import '../../../global_widgets/text.dart';
import '../controller.dart';
import 'tariffs_card.dart';

class Packages extends StatelessWidget {
  const Packages({required this.controller, super.key});
  final ItemsController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CasinoText(text: '(Above 21 Packages)',fontWeight: FontWeight.w600,color: Colors.white,fontSize: 20,),
          ),
          SizedBox(
            height: 600,
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
                      onTap: () {controller.onBook(id: controller.chipsList[index].id, amount: controller.chipsList[index].minAmount,title: 'chip');},)),
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CasinoText(text: '(Below 21 Packages)',fontWeight: FontWeight.w600,color: Colors.white,fontSize: 20,),
          ),
          SizedBox(
            height: 600,
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
                    onTap: () {controller.onBook(id: controller.chipsList[index].id, amount: controller.chipsList[index].minAmount,title: controller.chipsList[index].title);})),
              );
            }),
          ),
        ],
      ),
    );

  }
}