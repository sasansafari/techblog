import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/route_manager/names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Get.offAndToNamed(NamedRoute.routeMainScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(Assets.images.logo.path, height: Dimens.xlarge),
            SizedBox(
              height: Dimens.large,
            ),
            SpinKitFadingCube(
              color: SolidColors.primaryColor,
              size: Dimens.large,
            )
          ]),
        ),
      ),
    );
  }
}
