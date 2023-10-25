import 'package:casino/main.dart';
import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CasinoText extends StatelessWidget {
  const CasinoText({
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.fontFamily,
    this.maxLines,
    this.align,
    this.textStyle,
    this.overflow,
    super.key});

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final String? fontFamily;
  final int? maxLines;
  final TextAlign? align;
  final TextStyle? textStyle;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(text,
      maxLines: maxLines ?? 1,
      textAlign: align ?? TextAlign.center,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: textStyle ?? GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? CasinoColors.black,
      ),
      ),
    );
  }
}