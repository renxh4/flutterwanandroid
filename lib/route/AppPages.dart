
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../binding/HomeBinding.dart';
import '../main.dart';
import '../page/HomePage.dart';
import 'Routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
