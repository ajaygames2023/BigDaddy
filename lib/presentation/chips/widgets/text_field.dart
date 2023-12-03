import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants/colors.dart';

class ChipTextField extends StatelessWidget {
  const ChipTextField({
    required this.controller,
    this.length,
    this.enabled,
    this.labelText,
    this.keyboardType,
    this.onChanged,
    this.textCapitalization,
    super.key});
  final TextEditingController controller;
  final int? length;
  final bool? enabled;
  final String? labelText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.27,
      child: TextFormField(
        controller: controller,
        inputFormatters:[
          LengthLimitingTextInputFormatter(length ?? 10),
        ],
        onChanged: onChanged,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        keyboardType: keyboardType ?? TextInputType.number,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: CasinoColors.primary)
            ),
            enabled: enabled ?? true,
            focusColor: Colors.black,
            labelText: labelText ?? 'Enter Mobile Number',
            labelStyle: const TextStyle(color: CasinoColors.secondary)
          ),
        ),
    );
  }
}