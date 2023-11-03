import 'package:casino/global_widgets/text.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../global_widgets/form_field.dart';
import '../controller.dart';

class VerifyDocDetails extends StatelessWidget {
  const VerifyDocDetails({
    required this.formField,
    this.hint,
    required this.label,
    super.key});
  final TextEditingController formField;
  final String? hint;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CasinoText(text: label,color: CasinoColors.white,),
            const SizedBox(height: 10,),
            TextEditFormFiled(
              controller: formField,
              hintText: hint ??'Enter',),
            //   const SizedBox(height: 30,),
            //   CasinoText(text: label2,color: CasinoColors.white,),
            //   const SizedBox(height: 10,),
            // TextEditFormFiled(
            //   controller: formField2,
            //   hintText: hint2 ?? 'Enter',),
          ],
        ),
      ),
    );
  }
}