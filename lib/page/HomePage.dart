
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/HomeController.dart';
import '../l10n/app_localizations.dart';
import 'PageView.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.appTitle ?? ""),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.business), label: "业务"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "学校"),
        ],
        currentIndex: controller.selectedIndex.value,
        fixedColor: Colors.blue,
        onTap: (index) {
          controller.selectedIndex.value = index;
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: PageViewWidget(),
    );
  }


}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        //移除抽屉菜单顶部默认留白
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipOval(
                      child: Image.asset(
                        "images/icon_resolution_ratio.png",
                        width: 80,
                      ),
                    ),
                  ),
                  Text("Wendux", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text('Add account'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Manage accounts'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

