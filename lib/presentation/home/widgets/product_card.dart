import 'package:casino/global_widgets/text.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.title,
    required this.image,
    required this.onTap,
    super.key});
final String title;
final String image;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 211, 171, 68),
      shadowColor: Colors.black26,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // const SizedBox(height: 50,),
                   CasinoText(text: title,fontWeight: FontWeight.bold,fontSize: 40,color: CasinoColors.white,),
                  // const SizedBox(height: 50,),
                  Image.asset(image,color: CasinoColors.white,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.height * 0.3,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}