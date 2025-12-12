
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/HomeController.dart';
import '../l10n/app_localizations.dart';
import 'PageView.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController controller = Get.find<HomeController>();
  final PageController _pageController = PageController();

  void _onNavTapped(int index) {
    if (index == controller.selectedIndex.value) return;
    controller.selectedIndex.value = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    if (index == controller.selectedIndex.value) return;
    controller.selectedIndex.value = index;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.appTitle ?? ""),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      drawer: MyDrawer(),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
              BottomNavigationBarItem(icon: Icon(Icons.business), label: "业务"),
              BottomNavigationBarItem(icon: Icon(Icons.school), label: "学校"),
            ],
            currentIndex: controller.selectedIndex.value,
            fixedColor: Colors.blue,
            onTap: _onNavTapped,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: PageViewWidget(
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
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

