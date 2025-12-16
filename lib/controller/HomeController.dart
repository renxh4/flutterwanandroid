
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/BannerBean.dart';
import '../model/article_models.dart';
import '../network/ApiWanService.dart';

class HomeController extends GetxController {

  var selectedIndex = 0.obs;

  var bannerList = <BannerBean>[].obs;
  var articleList = <Article>[].obs;
  var currentPage = 0.obs;
  var isOver = false.obs;

  void getBanner() async {
    var response = await ApiWanService.instance.banner();
    bannerList.value = response.data ?? [];
  }

  /// 首次/下拉刷新
  Future<void> refreshArticles() async {
    currentPage.value = 0;
    isOver.value = false;
    final response = await ApiWanService.instance.getArticleList(currentPage.value);
    articleList.value = response.data?.datas ?? [];
    isOver.value = response.data?.over ?? true;
  }

  /// 上拉加载更多
  Future<void> loadMoreArticles() async {
    if (isOver.value) return;
    final next = currentPage.value + 1;
    final response = await ApiWanService.instance.getArticleList(next);
    final List<Article> more = response.data?.datas ?? [];
    articleList.addAll(more);
    currentPage.value = next;
    isOver.value = response.data?.over ?? true;
  }

}
