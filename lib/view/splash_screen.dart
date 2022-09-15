import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:tec/component/components.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      
      Get.offAndToNamed(TechBlogRoutes.homeScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(Assets.images.logo.path, height: 64),
            const SizedBox(
              height: 32,
            ),
            const SpinKitFadingCube(
              color: SolidColors.primeryColor,
              size: 32.0,
            )
          ]),
        ),
      ),
    );
  }
}
