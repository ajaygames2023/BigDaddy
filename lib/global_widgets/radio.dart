import 'package:casino/global_widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';

class RadioButtons extends StatefulWidget {
  const RadioButtons({required this.groupValue, required this.callBack,super.key,});
  final String groupValue;
  final ValueChanged<String> callBack;

  @override
  State<RadioButtons> createState() => RadioButtonsState();
}

class RadioButtonsState extends State<RadioButtons> {
  late String groupValue;

    String getValue(String type){
    switch(type) {
      case 'A':
        return 'Aadhar Card';
      case 'P':
        return 'PAN';
      default:
        return 'Aadhar Card';
    }
  }

  @override
  void initState() {
    groupValue = getValue(widget.groupValue);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: CasinoText(text: 'Select to upload document.',textStyle: GoogleFonts.abel(fontSize: 20,fontWeight: FontWeight.w600,color: const Color.fromARGB(255, 255, 205, 78),),)),
          // ),
          const SizedBox(height: 12,),
          Transform.scale(
            scale: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: RadioGroup<String>.builder(
                fillColor: const Color.fromARGB(255, 255, 206, 60),
              textStyle: const TextStyle(color: Colors.white,fontSize: 14),
                direction: Axis.horizontal,
                groupValue: groupValue,
                onChanged: (value) => setState(() {
                  groupValue = value ?? 'Aadhar Card';
                  widget.callBack(value!.substring(0,1));
                }),
                items: const ['Aadhar Card','Pan'],
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
            ),
          ),
    
        ],
      ),
    );
  }
}