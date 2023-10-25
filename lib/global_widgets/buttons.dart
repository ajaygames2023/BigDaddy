import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';


class CasinoButton extends StatelessWidget {
  const CasinoButton({
    this.title,
    this.titleColor,
    this.fontSize,
    this.fontWeight,
    this.backgroundColor,
    this.onTap,
    this.borderColor,
    this.height,
    this.width,
    this.radius,
    this.enabled,
    this.textStyle,
    super.key});

  final String? title;
  final double? fontSize;
  final Color? titleColor;
  final FontWeight? fontWeight;
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback? onTap;
  final double? height;
  final double? width;
  final double? radius;
  final bool? enabled;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (enabled ?? true) ? onTap : null,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: borderColor!= null ? Border.all(color:borderColor!) : null,
            borderRadius: BorderRadius.circular(radius ?? 7),
            gradient: backgroundColor == null ? LinearGradient(colors: [
              Color.fromARGB(255, 239, 186, 51),
              Color.fromARGB(255, 243, 215, 143),
              Color.fromARGB(255, 239, 186, 51),
            ]) : null,
           // border: Border.all(color: (enabled ?? true) ? borderColor ?? const CasinoColors.secondary  : borderColor?.withOpacity(0.5) ?? CasinoColors.primary.withOpacity(0.5)),
            color: (enabled ?? true) ? backgroundColor ?? Color.fromARGB(255, 18, 17, 17) : backgroundColor?.withOpacity(0.5) ?? CasinoColors.primary.withOpacity(0.5)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 5),
          child: Center(child: Text(title ?? 'Login',style:TextStyle(  fontSize: fontSize ?? 16,color: titleColor ?? CasinoColors.secondary,fontWeight: fontWeight ?? FontWeight.w500,)),
        ),
      ),
    ));
  }
}