import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'doc_upload.dart';

class Doc extends StatelessWidget {
  const Doc({
    this.groupValue = 'Aadhar Card',
    this.panImage,
    this.aadharBackImage,
    this.aadharFrontImage,
    this.panStatus,
    this.aadharStatus,
    this.callBack,
    super.key});
  final String groupValue;
  final XFile? panImage;
  final XFile? aadharFrontImage;
  final XFile? aadharBackImage;
  final String? panStatus;
  final String? aadharStatus;
  final Function(String typeImage)? callBack;

  @override
  Widget build(BuildContext context) {
    return (groupValue != 'Aadhar Card') 
    ? SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.18,
      child: DottedBorder(
        color:const Color.fromARGB(255, 250, 198, 65),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(child: DocUpload(image: panImage,callBack: () => callBack!('pan'))),
        )),
    )
    : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.18,
            child: DottedBorder(
              color:const Color.fromARGB(255, 250, 198, 65),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: DocUpload(image: aadharFrontImage,callBack: () => callBack!('fontAadhar'),)),
              )),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.2,),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.18,
            child: DottedBorder(
              color:const Color.fromARGB(255, 250, 198, 65),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: DocUpload(image: aadharBackImage,callBack: () => callBack!('backAadhar'),)),
              )),
          ),
        ],
      ),
    );
  }
}