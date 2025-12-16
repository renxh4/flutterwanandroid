
import 'package:flutter/material.dart';
import 'package:flutterwanandroid/page/HomePageView.dart';
import 'package:flutterwanandroid/utils/KeepAliveWrapper.dart';

const String pageViewHome = "首页";
const String pageViewQa = "问答";
const String pageViewWx = "公众号";

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  final PageController controller;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      onPageChanged: onPageChanged,
      children: const <Widget>[
        _SimplePage(text: pageViewHome),
        _SimplePage(text: pageViewQa),
        _SimplePage(text: pageViewWx),
      ],
    );
  }
}


class _SimplePage extends StatelessWidget{
  const _SimplePage({
    Key? key,
    required this.text
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    if (text == pageViewHome) {
      return KeepAliveWrapper(child: HomePageView());
    } else if (text == pageViewQa) {
      return KeepAliveWrapper(child: const Center(child: Text(pageViewQa, textScaleFactor: 5)));
    } else if (text == pageViewWx) {
      return KeepAliveWrapper(child: const Center(child: Text(pageViewWx, textScaleFactor: 5)));
    } else {
      return KeepAliveWrapper(child: const Center(child: Text("未知页面", textScaleFactor: 5)));
    }
  }

}
