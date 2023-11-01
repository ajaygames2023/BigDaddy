import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'controller.dart';

class PaymentDialog extends GetView<PaymentDialogController> {
  const PaymentDialog({
    required this.callBack,
    this.amount,
    this.isKyc,
    super.key});
  final Function(String? paymentMode,String? paymentType,String? txnNo,String? panNo) callBack;
  final String? amount;
  final bool? isKyc;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentDialogController>(
      init: PaymentDialogController(),
      builder: (context) {
        return SizedBox(
          height: 300,
          width: 600,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: RadioGroup<String>.builder(
                      fillColor: const Color.fromARGB(255, 255, 206, 60),
                    textStyle: const TextStyle(color: CasinoColors.secondary,fontSize: 18,fontWeight: FontWeight.bold),
                      direction: Axis.horizontal,
                      groupValue: controller.paymentModeGroupValue,
                      onChanged: (value) { controller.selectPaymentMode(value ?? 'Digital');},
                      items: const ['Cash','Digital'],
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                if(controller.paymentModeGroupValue == 'Digital') Transform.scale(
                  scale: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: RadioGroup<String>.builder(
                      fillColor: const Color.fromARGB(255, 255, 206, 60),
                    textStyle: const TextStyle(color: CasinoColors.secondary,fontSize: 18,fontWeight: FontWeight.bold),
                      direction: Axis.horizontal,
                      groupValue: controller.paymentTypeGroupValue,
                      onChanged: (value) { controller.selectPaymentModeType(value ?? 'UPI');},
                      items: const ['UPI','Net Banking','Credit Card','Debit Card'],
                      itemBuilder: (item) => RadioButtonBuilder(
                        item,
                      ),
                    ),
                  ),
                ),
                if(controller.paymentModeGroupValue == 'Digital') const SizedBox(height: 20,),
                CasinoText(text: 'Total Amount : Rs $amount'),
                 const SizedBox(height: 20,),
                (controller.paymentModeGroupValue == 'Digital') ? Row(
                  children: [
                    const CasinoText(text: 'Transaction Id :'),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextFormField(
                        controller: controller.txnNo,
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(20),
                        ],
                        keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusColor: Colors.black,
                            labelText: 'Enter Transaction Id',
                          ),
                      ),
                    ),
                  ],
                ) : (isKyc ?? false) ? (num.parse(amount??'') >= 200000 ) ? Row(
                  children: [
                    const CasinoText(text: 'PAN Number :'),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: 250,
                      height: 50,
                      child: TextFormField(
                        controller: controller.panNo,
                        inputFormatters:[
                          LengthLimitingTextInputFormatter(20),
                        ],
                        keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            focusColor: Colors.black,
                            labelText: 'Enter Pan Number',
                          ),
                      ),
                    ),
                  ],
                ) : const SizedBox.shrink():const SizedBox.shrink(),
                 const SizedBox(height: 40,),
                 Center(child: CasinoButton(title: 'Generate Invoice',height: 50,width: 300,fontSize: 20,fontWeight: FontWeight.bold,
                 onTap: () => callBack(controller.paymentModeGroupValue,controller.paymentTypeGroupValue,controller.txnNo.text,controller.panNo.text),
                 ))
              
              ],
            ),
          ),
        );
      }
    );
  }
}