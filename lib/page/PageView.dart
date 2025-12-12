
import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Container(
        color: Colors.red,
        padding: EdgeInsets.all(10.0),
        child: Center(child: Text("$index")),
      ),
    );
  }
}


class Page extends StatelessWidget{
  const Page({
    Key? key,
    required this.text
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text, textScaleFactor: 5));

  }

}
