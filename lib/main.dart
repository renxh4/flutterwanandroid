import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterwanandroid/binding/TestBinding.dart';
import 'package:flutterwanandroid/route/AppPages.dart';
import 'package:flutterwanandroid/route/Routes.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'GlobalConfig.dart';
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