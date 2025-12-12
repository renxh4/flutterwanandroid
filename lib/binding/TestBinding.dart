
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../controller/TestController.dart';

class TestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestController>(() => TestController());
  }
}
