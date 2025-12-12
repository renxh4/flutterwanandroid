
import 'package:flutter/material.dart';

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
        _SimplePage(text: '首页'),
        _SimplePage(text: '业务'),
        _SimplePage(text: '学校'),
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
    return Center(child: Text(text, textScaleFactor: 5));

  }

}
