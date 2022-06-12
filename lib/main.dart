import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tec/my_colors.dart';
import 'package:tec/view/main_screen.dart';
import 'package:tec/view/my_cats.dart';
import 'package:tec/view/register_intro.dart';
 
void main() {

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    
    statusBarColor: SolidColors.statusBarColor,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: SolidColors.systemNavigationBarColor,
    systemNavigationBarIconBrightness: Brightness.dark
    
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    var textTheme = Theme.of(context).textTheme;


    return MaterialApp(
      localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
           ],
      supportedLocales: const [
        Locale('fa', ''), // farsi
      ],
      theme: ThemeData(


          inputDecorationTheme: InputDecorationTheme(

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(width: 2),
              
              
              ),
              filled: true,
              fillColor: Colors.white
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(style:  ButtonStyle(
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
                )),



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
                  fontFamily: 'dana',
                  fontSize: 13,
                  fontWeight: FontWeight.w300),
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
                  fontWeight: FontWeight.w700)
                  
                  
                  )),
      debugShowCheckedModeBanner: false,
      // home: splashScreen()
      home:   MyCats()
    );
  }
}
 