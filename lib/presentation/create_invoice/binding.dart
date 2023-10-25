import 'package:get/get.dart';
import 'controller.dart';

class InvoiceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InvoiceController>(() => InvoiceController());
  }
}