
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/BannerBean.dart';
import '../network/ApiWanService.dart';

class HomeController extends GetxController {

  var selectedIndex = 0.obs;

  var bannerList = <BannerBean>[].obs;

  void getBanner() async {
    var response = await ApiWanService.instance.banner();
    bannerList.value = response.data ?? [];
  }

  void getArticleList() async {
    var response = await ApiWanService.instance.getArticleList();
    response.data?.datas?.forEach((element) {
      print(element.title);
    });
  }

}
