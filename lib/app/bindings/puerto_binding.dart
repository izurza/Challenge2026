import 'package:challege_2026/app/controllers/puerto_controller.dart';
import 'package:get/get.dart';

class PuertoBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<PuertoController>(() => PuertoController());
  }
}