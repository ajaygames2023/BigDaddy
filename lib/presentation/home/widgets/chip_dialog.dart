import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../global_widgets/buttons.dart';
import '../../../global_widgets/text.dart';

class Chips extends StatefulWidget {
  const Chips({
    required this.amount,
    this.isDiscount,
    required this.totalAmount,
    required this.callBack,
    super.key});
  final TextEditingController amount;
  final bool? isDiscount;
  final String totalAmount;
  final Function(String amount,String discount,String amountAfterDiscoun) callBack;

  @override
  State<Chips> createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
String totalAmount = '0';
String valueAmount = '0';
String discountAmount = '0';
bool isDiscount = false ;
  @override
  void initState() {
    isDiscount = widget.isDiscount ?? false;
    super.initState();
  }

String totalAmountWithDiscount(String value) {
  if(isDiscount) {
    discountAmount = ((1/10)*num.parse(value)).toStringAsFixed(1);
  return (num.parse(value) - ((1/10)*num.parse(value))).toStringAsFixed(1);
  }
  return value;
}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CasinoText(text: 'Payment mode'),
                CasinoText(text: 'Online'),
              ],
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: 200,
              height: 50,
              child: TextFormField(
              inputFormatters:[
                LengthLimitingTextInputFormatter(6),
              ],
              onChanged: (value) {
                setState(() {
                  valueAmount = value;
                  totalAmount = totalAmountWithDiscount(value);
                });
              },
              keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Colors.black,
                 // icon: Icon(Icons.person),
                  labelText: 'Amount',
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CasinoText(text: 'IsDiscount (10%)'),
              CupertinoSwitch(
                activeColor: CasinoColors.primary,
              value: isDiscount,
              onChanged: (value) {
                setState(() {
                  isDiscount = value;
                  totalAmount = totalAmountWithDiscount(valueAmount);
                });
              },
            ),
                // Row(
                //   children: [
                //     CasinoButton(
                //       width: 60,
                //       height: 30,
                //       backgroundColor: Colors.white,
                //       borderColor: Colors.black,
                //       title: 'Yes',
                //       onTap: () {
                //         isDiscount = true;
                //         totalAmount = totalAmountWithDiscount(valueAmount);
                //         setState(() {});
                //       },
                //     ),
                //      const SizedBox(width: 30,),
                //     CasinoButton(
                //       width: 60,
                //       height: 30,
                //       backgroundColor: Colors.white,
                //       borderColor: Colors.black,
                //       title: 'No',
                //       onTap: () {
                //         isDiscount = false;
                //         totalAmount = totalAmountWithDiscount(valueAmount);
                //         setState(() {});
                //       },
                //     ),
                //   ],
                // )

              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CasinoText(text: 'Total Amount'),
                CasinoText(text: totalAmount.toString()),
              ],
            ),
            const SizedBox(height: 20,),
            Center(
              child: CasinoButton(
                onTap:() {widget.callBack(valueAmount,discountAmount,totalAmount);},
                width: 100,
                title: 'Submit',),
            )
            
          ]),
        ),
      );

  }
}