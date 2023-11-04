import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextEditFormFiled extends StatelessWidget {
  const TextEditFormFiled({Key? key,
    required this.controller,
    this.maxLength,
    this.hintText,
    this.enabled,
    this.keyboardType,}) : super(key: key);

    final TextEditingController controller;
    final int? maxLength;
    final String? hintText;
    final TextInputType? keyboardType;
    final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: controller,
      enabled: enabled ?? true,
      scrollPadding: EdgeInsets.zero,
      keyboardType: keyboardType ?? TextInputType.text,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      cursorColor: CasinoColors.primary,
      style: const TextStyle(
          color: CasinoColors.primary
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: CasinoColors.primary,fontSize: 14),
      //  filled: true,
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: CasinoColors.primary,width: 2),),
       // alignLabelWithHint: true,
        focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: CasinoColors.primary,width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: CasinoColors.primary,width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CasinoColors.primary.withOpacity(0.5),width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}