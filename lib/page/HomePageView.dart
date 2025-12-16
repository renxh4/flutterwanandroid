import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controller/HomeController.dart';
import '../utils/date_time_utils.dart';
import 'webview_page.dart';

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
  final RefreshController _controller = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    super.initState();
    homeController.getBanner();
    homeController.refreshArticles();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullUp: true,
      controller: _controller,
      onRefresh: () async {
        homeController.getBanner();
        homeController.refreshArticles();
        _controller.refreshCompleted();
      },
      onLoading: () async {
        homeController.loadMoreArticles();
        _controller.loadComplete();
      },

      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Obx(
                () => PageView.builder(
                  controller: _pageController,
                  itemCount: homeController.bannerList.length,
                  itemBuilder: (context, index) => SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Image.network(
                          homeController.bannerList[index].imagePath ?? "",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            color: Colors.black.withOpacity(0.5),
                            child: Text(
                              homeController.bannerList[index].title ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = homeController.articleList[index];
                final String url = item.link ?? '';
                final String title = item.title ?? '';
                return InkWell(
                  onTap: () {
                    if (url.isEmpty) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(const SnackBar(content: Text('无效的链接')));
                      return;
                    }
                    Get.to(() => WebViewPage(url: url, title: title));
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRow(index),
                        SizedBox(height: 8),
                        Text(title, style: TextStyle(fontSize: 18)),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(item.superChapterName ?? ""),
                            Spacer(),
                            Icon(
                              Icons.heart_broken,
                              size: 24,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: homeController.articleList.length),
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
          padding: EdgeInsets.only(left: 2, right: 2, bottom: 1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.red, width: 1),
          ),
          child: Text("新", style: TextStyle(color: Colors.red, fontSize: 10)),
        ),
        SizedBox(width: 5),
        Text(
          homeController.articleList[index].shareUser ?? "",
          style: TextStyle(fontSize: 14),
        ),
        Spacer(),
        Text(
          DateTimeUtils.formatTimestamp(
            homeController.articleList[index].shareDate ?? 0,
          ),
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
