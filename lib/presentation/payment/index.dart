import 'package:flutter/material.dart';

import '../../global_widgets/text.dart';
import '../../utils/constants/colors.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CasinoColors.secondary,
        title: const CasinoText(text: 'Payment',color: Color.fromARGB(255, 250, 198, 65),fontWeight: FontWeight.bold,),
         ),
      body: Column(
        children: [
          
        ],
      ),
    );
  }
}