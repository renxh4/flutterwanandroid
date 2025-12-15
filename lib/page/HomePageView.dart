import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/HomeController.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageViewState();
  }
}

class _HomePageViewState extends State<HomePageView> {
  final PageController _pageController = PageController();
  var homeController = Get.find<HomeController>();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.red,
            child: Obx(
              () => PageView.builder(
                controller: _pageController,
                itemCount: homeController.bannerList.length,
                itemBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.network(
                    homeController.bannerList[index].imagePath ?? "",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: homeController.bannerList.length,
                itemBuilder: (context, index) => Container(
                  height: 50,
                  color: Colors.red,
                  child: Center(child: Text("$index")),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
