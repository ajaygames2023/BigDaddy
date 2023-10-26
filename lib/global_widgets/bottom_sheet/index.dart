import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class CasinoBottomSheet extends StatelessWidget {
  const CasinoBottomSheet({
    required this.child,
    super.key});
  final Widget Function(CasinoBottomSheetController controller) child;

    Widget get popOverChild => GetBuilder<CasinoBottomSheetController>(
      init: CasinoBottomSheetController(),
      global: false,
      builder: (controller) {
        return child(controller);
      });

  @override
  Widget build(BuildContext context) {
    return popOverChild;
  }
}