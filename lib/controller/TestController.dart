
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TestController extends GetxController {
  var count = 0;
  void increment() => count++;

  get getCount => count;
}
