import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constants/colors.dart';

class DocumentUpload extends StatelessWidget {
  const DocumentUpload({
    this.image,
    this.callBack,
    super.key, });
  final XFile? image;
  final VoidCallback? callBack;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callBack,
      child: SizedBox(
        height: 200,
        child:  (image == null) ? const Center(
          child: Icon(Icons.camera_alt_outlined,color: Color.fromARGB(255, 238, 197, 92),size: 100,),
        ) : Image.file(File(image?.path ?? ''))),
    );
  }
}