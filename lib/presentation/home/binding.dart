import 'package:get/get.dart';
import 'controller.dart';

class ItemsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemsController>(() => ItemsController());
  }
}