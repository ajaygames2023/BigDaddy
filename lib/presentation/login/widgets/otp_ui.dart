import 'package:casino/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class OTPUI extends StatelessWidget {
  const OTPUI({
    required this.pinEditingController,
    super.key});
  final TextEditingController pinEditingController;

  @override
  Widget build(BuildContext context) {
    return PinInputTextField(
      pinLength: 6,
      decoration: BoxLooseDecoration(
      bgColorBuilder: PinListenColorBuilder(const Color.fromARGB(255, 246, 209, 115), const Color.fromARGB(255, 246, 209, 115)),
      strokeColorBuilder: PinListenColorBuilder(Color.fromARGB(153, 0, 0, 0), Color.fromARGB(153, 0, 0, 0)),
      ),
      controller: pinEditingController,
      textInputAction: TextInputAction.go,
      keyboardType: TextInputType.number,
      textCapitalization: TextCapitalization.characters,
      onSubmit: (pin) {
        debugPrint('submit pin:$pin');
      },
      onChanged: (pin) {
        debugPrint('onChanged execute. pin:$pin');
      },
      enableInteractiveSelection: false,
    );
  }
}