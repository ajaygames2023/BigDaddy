import 'package:casino/global_widgets/buttons.dart';
import 'package:flutter/material.dart';

import '../../../global_widgets/text.dart';

class TariffsCard extends StatelessWidget {
  const TariffsCard({
    required this.title,
    required this.amount,
    this.image,
    required this.onTap,
    super.key});
  final String? image;
  final String title;
  final String amount;
  final VoidCallback onTap;

  Text getText(String text) {
    return  Text.rich(
        TextSpan(
          children: [
            const TextSpan(
              text: '• ',
              style: TextStyle(color: Color.fromARGB(255, 246, 209, 115),fontSize: 20,fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: text,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        maxLines: 5,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      decoration: BoxDecoration(
        color: Colors.black,
        gradient: const RadialGradient(colors: [
          Color.fromARGB(255, 246, 209, 115),
          Color.fromARGB(255, 0, 0, 0),
        ]),
        border: Border.all(
          color: Colors.white
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(image ?? 'assets/images/Day-Final.png'),
                  CasinoText(text: title,fontWeight: FontWeight.w600,color: Colors.white,fontSize: 20,),
                  const Divider(color: Colors.white,height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     const CasinoText(text: 'Starting From',fontWeight: FontWeight.w400,color: Colors.white,fontSize: 16,),
                      CasinoText(text: 'Rs $amount',fontWeight: FontWeight.w600,color: Colors.white,),
                    ],
                  ),
                  const Divider(color: Colors.white,height: 30,),
                  getText('₹ 2000 per adult with promotional voucher worth ₹1000 (Age 21+)'),
                  getText('Unlimited House Brand Drinks (alcoholic and non-alcoholic)'),
                  getText('Taxes'),
              ]),
            ),
            CasinoButton(title: 'Book Now',
            onTap: (){onTap();},
            backgroundColor: Colors.black,
            borderColor: Color.fromARGB(255, 246, 209, 115),
            titleColor: Color.fromARGB(255, 246, 209, 115),
            height: 50,
            width: 200,),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}