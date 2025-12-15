import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/HomeController.dart';
import '../utils/date_time_utils.dart';

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
                itemCount: homeController.articleList.length,
                itemBuilder: (context, index) => Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildRow(index),
                      SizedBox(height: 8,),
                      Text(homeController.articleList[index].title ?? "",style: TextStyle(fontSize: 18)),
                      SizedBox(height: 8,),
                      Row(
                        children: [
                          Text(homeController.articleList[index].superChapterName ?? ""),
                          Spacer(),
                          Icon(Icons.heart_broken,size: 24,color: Colors.red,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row buildRow(int index) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(left: 2, right: 2,bottom: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.red, width: 1),
          ),
          child: Text("新", style: TextStyle(color: Colors.red, fontSize: 10)),
        ),
        SizedBox(width: 5,),
        Text(homeController.articleList[index].shareUser ?? "",style: TextStyle(fontSize: 14),),
        Spacer(),
        Text(DateTimeUtils.formatTimestamp(homeController.articleList[index].shareDate ?? 0),style: TextStyle(fontSize: 14),),
      ],
    );
  }
}
