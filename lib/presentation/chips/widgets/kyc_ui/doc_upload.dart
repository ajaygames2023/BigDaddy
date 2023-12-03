import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DocUpload extends StatelessWidget {
  const DocUpload({
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
        height: MediaQuery.of(context).size.height * 0.2,
        child:  (image == null) ? const Center(
          child: Icon(Icons.camera_alt_outlined,color: Color.fromARGB(255, 238, 197, 92),size: 50,),
        ) : (image!.path.contains('pdf')) ? SfPdfViewer.file(File(image?.path ?? '',)) : Image.file(File(image?.path ?? ''),fit: BoxFit.contain,)),
    );
  }
}