import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterwanandroid/binding/TestBinding.dart';
import 'package:flutterwanandroid/controller/HomeController.dart';
import 'package:flutterwanandroid/model/HttpBinGetResponse.dart';
import 'package:flutterwanandroid/network/ApiMainService.dart';
import 'package:flutterwanandroid/route/AppPages.dart';
import 'package:flutterwanandroid/route/Routes.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'GlobalConfig.dart';
import 'controller/TestController.dart';
import 'l10n/app_localizations.dart';

void main() {
  GlobalConfig.init().then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,//-----这里是新加的一行
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      supportedLocales: [
        const Locale('zh'),
        const Locale('en'),
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: Routes.home,
      getPages: AppPages.pages,
      initialBinding: TestBinding(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)?.appTitle ?? ""),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:  () async {
          _counter = Get.find<TestController>().getCount;
          var sss = Get.find<HomeController>().getCount;

          print("点击了图标按钮111${_counter} sss=${sss}");
          //简单网络连通性测试：调用 httpbin 的 GET 接口
          try {
            final api = ApiMainService('https://httpbin.org');
            final HttpBinGetResponse resp = await api.pingGetModel();
            print("网络连通成功: url121=${resp.url}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("网络连通成功: ${resp.url}")),
            );
          } catch (e) {
            print("网络异常: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("网络异常: $e")),
            );
          }

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
