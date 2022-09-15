import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:tec/component/components.dart';
import 'package:tec/routes/routes.dart';

import 'my_http_overrides.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      locale: const Locale('fa'),
      theme: lightTheme(textTheme),
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      // home: Single()
      // home: SplashScreen()
      initialRoute: TechBlogRoutes.splashScreen,
    );
  }
}

// const String routeMainScreen = "/MainScreen";
// const String routeSingleArticle = "/SingleArticle";
