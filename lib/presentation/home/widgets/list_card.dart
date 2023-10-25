import 'package:casino/global_widgets/buttons.dart';
import 'package:casino/global_widgets/text.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    required this.index,
    this.isSelected = false,
    this.priceTitle,
    this.hintPrice,
    this.onTap,
    super.key});
  final int index;
  final bool isSelected;
  final String? priceTitle;
  final String? hintPrice;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: !isSelected ? const Color.fromARGB(255, 67, 56, 94) : Colors.black12,
            borderRadius: BorderRadius.circular(8)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset('assets/images/casino_chips.png',scale: 10,color: Colors.white,)),
                CasinoText(text: priceTitle ?? 'Regular Pack',fontWeight: FontWeight.w600,color: Colors.white,),
                const Divider(color: Colors.white,),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CasinoText(text: 'Starting From',fontWeight: FontWeight.w400,color: Colors.white,),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: TextField(
                        style: const TextStyle(color: Colors.white,fontSize: 20),  
                        keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,  
                        hintText: hintPrice ?? '2000',
                        labelStyle: const TextStyle(color: Colors.white,fontSize: 20),
                        hintStyle: const TextStyle(color: Colors.white,fontSize: 20),
                      ),  
                      ),
                    ), 
                  ],
                ),
                const Divider(color: Colors.white,),
                const CasinoText(text: '10 % discount ',fontWeight: FontWeight.w400,color: Colors.white,),
                // const Center(
                //   child: CasinoButton(
                //     backgroundColor: Colors.black,
                //     width: 200,
                //     title: 'Book Now',),
                // )
              ],
            ),
            ),
        ),
      )
    );
  }
}