import 'dart:typed_data';

import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_upi/get_upi.dart';

import '../domain/models/invoice/invoice_generate.dart';

class Payment extends StatefulWidget {
  const Payment({
    this.upiAppsListAndroid,
    this.onSuccess,
    super.key});
  final List<UpiObject>? upiAppsListAndroid;
  final VoidCallback? onSuccess;

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {

bool isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return (isSuccess) ? getSuccessScreen() : Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          getUpiApps(),
          const SizedBox(height: 20,),
          getNetBanking(),
          const SizedBox(height: 40,),
          CasinoButton(title: 'Pay',width: 100,onTap: () {
            setState(() {
              isSuccess = !isSuccess;
            });
            
          },)
      ],),
    );
  }

  Widget getSuccessScreen() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image:AssetImage('assets/images/congratulations.gif',),fit: BoxFit.fill),
      ),
      child: Expanded(
        child: SizedBox(
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/payment_success.gif',scale: 0.5,),
                CasinoButton(title: 'ok',width: 100,onTap: widget.onSuccess,)
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget getUpiApps() {
    return  SizedBox(
      width: double.infinity,
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
             children: [
              const CasinoText(text: 'Upi Payment',color: CasinoColors.white,fontWeight: FontWeight.bold,fontSize: 18,),
              const SizedBox(height: 20,),
              Wrap (
                children: widget.upiAppsListAndroid!.map<Widget>((UpiObject app) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                      //  openUPI(app);
                      },
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20,),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
                          //   child: Image.network(
                          //     app.icon,
                          //     repeat: ImageRepeat.noRepeat,
                          //     height: 30,
                          //   ),
                          // ),
                          const SizedBox(height: 10,),
                          Text(app.name,softWrap: true,style: const TextStyle(fontSize: 12,color: Colors.white),),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              ],
           ),
    );
  }

    Widget getNetBanking() {
    return const SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CasinoText(text: 'Card Payment',color: CasinoColors.white,fontWeight: FontWeight.bold,fontSize: 18,)),
            SizedBox(height: 20,),
            CasinoButton(title: 'Card',width: 100,)
        ],
      ),
    );
  }
}