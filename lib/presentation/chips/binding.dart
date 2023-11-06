import 'package:get/get.dart';
import 'controller.dart';

class ChipBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChipController>(() => ChipController());
  }
}