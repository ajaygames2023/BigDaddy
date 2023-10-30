import 'package:casino/global_widgets/text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'document_upload.dart';

class Documents extends StatelessWidget {
  const Documents({
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
      width: MediaQuery.of(context).size.width * 0.5,
      child: DottedBorder(
        color:const Color.fromARGB(255, 250, 198, 65),
        child: Center(child: DocumentUpload(image: panImage,callBack: () => callBack!('pan')))),
    )
    : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: DottedBorder(
              color:const Color.fromARGB(255, 250, 198, 65),
              child: Center(child: DocumentUpload(image: aadharFrontImage,callBack: () => callBack!('fontAadhar'),))),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
          Expanded(
            child: DottedBorder(
              color:const Color.fromARGB(255, 250, 198, 65),
              child: Center(child: DocumentUpload(image: aadharBackImage,callBack: () => callBack!('backAadhar'),))),
          ),
        ],
      ),
    );
  }
}