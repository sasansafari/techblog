import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'constant/my_colors.dart';
import 'themes/app_themes.dart';
import 'my_http_overrides.dart';
import 'route_manager/names.dart';
import 'route_manager/pages.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('fa'),
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      initialRoute: NamedRoute.initialRoute,
    );
  }
}
