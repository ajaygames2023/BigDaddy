import 'package:casino/presentation/chips/controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../global_widgets/text.dart';
import '../../utils/constants/colors.dart';

class ChipsPurchage extends StatelessWidget {
  const ChipsPurchage({
    required this.controller,
    super.key});
  final ChipController controller;

  @override
  Widget build(BuildContext context) {
return  DottedBorder(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
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
          const SizedBox(
            height: 10,
            child: Divider(
              thickness: 2,
              color: CasinoColors.black,
            ),
          ),
          const SizedBox(height: 20,),
          controller.getRowWidget(title: 'Chips Face Value',amount: controller.valueAmount.toString()),
          const SizedBox(height: 10,),
          controller.getRowWidget(title: 'Less Discount',amount: controller.getDiscount(controller.valueAmount.toString())),
          const SizedBox(height: 10,),
          controller.getRowWidget(title: 'Chips Worth',amount: controller.getFaceValue(controller.valueAmount.toString())),
          const SizedBox(height: 10,),
          controller.getRowWidget(title: 'SGST(14%)',amount: controller.getGST(controller.valueAmount)),
          const SizedBox(height: 10,),
          controller.getRowWidget(title: 'CGST(14%)',amount: controller.getGST(controller.valueAmount)),
          const SizedBox(height: 10,),
          controller.getRowWidget(title: 'Total Amount',amount: controller.valueAmount.toString()),
        ],
      ),
  ),
);


  }
}