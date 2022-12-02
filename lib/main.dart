import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/binding.dart';
import 'package:tec/constant/my_colors.dart';

import 'package:tec/view/articles/manage_article.dart';
import 'package:tec/view/articles/single.dart';
import 'package:tec/view/articles/single_manage_article.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/podcast/single_podcast.dart';
   import 'package:tec/view/splash_screen.dart';
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
        getPages: [
          GetPage(
              name: NamedRoute.routeMainScreen,
              page: () => const MainScreen(),
              binding: RegisterBinding()),
          GetPage(
              name: NamedRoute.routeSingleArticle,
              page: () => Single(),
              binding: ArticleBinding()),
          GetPage(
              name: NamedRoute.manageArticle,
              page: () => ManageArticle(),
              binding: ArticleManagerBinding()),
          GetPage(
              name: NamedRoute.singleManageArticle,
              page: () => SingleManageArticle(),
              binding: ArticleManagerBinding()),
        ],
        // home: Single()
        // home: const SplashScreen());
        home: const PodcastSingle());
       
        
  }

  ThemeData lightTheme(TextTheme textTheme) {
    return ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return textTheme.headline1;
              }
              return textTheme.subtitle1;
            }),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return SolidColors.seeMore;
              }
              return SolidColors.primeryColor;
            }),
          ),
        ),
        fontFamily: 'dana',
        brightness: Brightness.light,
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontFamily: 'dana',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: SolidColors.posterTitle),
          subtitle1: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: SolidColors.posterSubTitle),
          bodyText1: TextStyle(
              fontFamily: 'dana', fontSize: 13, fontWeight: FontWeight.w300),
          headline2: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.w300),
          headline3: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: SolidColors.seeMore,
              fontWeight: FontWeight.w700),
          headline4: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: Color.fromARGB(255, 70, 70, 70),
              fontWeight: FontWeight.w700),
          headline5: TextStyle(
              fontFamily: 'dana',
              fontSize: 14,
              color: SolidColors.hintText,
              fontWeight: FontWeight.w700),
        ));
  }
}



class NamedRoute{
static String routeMainScreen = "/MainScreen";
static String routeSingleArticle = "/SingleArticle";
static String manageArticle = "/ManageArticle";
static String singleManageArticle = "/SingleManageArticle";


}