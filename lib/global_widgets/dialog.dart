import 'package:casino/global_widgets/text.dart';
import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  const DialogBox({required this.title,this.onClose,this.buttonTitle,this.onTap,required this.child,this.padding,this.titleFont,this.titleColor,this.enabled,super.key});
  final String title;
  final VoidCallback? onClose;
  final String? buttonTitle;
  final VoidCallback? onTap;
  final Widget child;
  final double? padding;
  final double? titleFont;
  final Color? titleColor;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
      titlePadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0))),
      title: Container(
        width: MediaQuery.of(context).size.width/2,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(7),topRight: Radius.circular(7)),
          color: titleColor ?? Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Expanded(child: Center(child: CasinoText(text: title,fontSize: titleFont ?? 18,fontWeight: FontWeight.w400,color: Colors.white,maxLines: 2,))),
            (onClose != null) ? Padding(
              padding: const EdgeInsets.only(right: 0),
              child: IconButton(onPressed: onClose, icon: const Icon(Icons.close,size: 30,color: Colors.white,)),
            ): const SizedBox.shrink(),
          ],),
        ),
      ),
      content: child );
  }
}