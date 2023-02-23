import 'package:flutter/material.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:get/get.dart';
import '../../controller/register_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.profileAvatar.path,
                height: 100,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    Image.asset(Assets.icons.bluePen.path).image,
                    color: SolidColors.seeMore,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    MyStrings.imageProfileEdit,
                    style: textTheme.displaySmall,
                  )
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Text(
                "فاطمه امیری",
                style: textTheme.headlineMedium,
              ),
              Text(
                "fatemeamiri@gmail.com",
                style: textTheme.headlineMedium,
              ),
              const SizedBox(
                height: 40,
              ),
              TechDivider(size: size),
              InkWell(
                onTap: (() {
                  //یه چیزی اجرا بشه
                }),
                splashColor: SolidColors.primaryColor,
                child: SizedBox(
                    height: 45,
                    child: Center(
                        child: Text(
                      MyStrings.myFavBlog,
                      style: textTheme.headlineMedium,
                    ))),
              ),
              TechDivider(size: size),
              InkWell(
                onTap: (() {
                  //یه چیزی اجرا بشه
                }),
                splashColor: SolidColors.primaryColor,
                child: SizedBox(
                    height: 45,
                    child: Center(
                        child: Text(
                      MyStrings.myFavPodcast,
                      style: textTheme.headlineMedium,
                    ))),
              ),
              TechDivider(size: size),
              InkWell(
                onTap: (() {
                  Get.find<RegisterController>().logOut();
                }),
                splashColor: SolidColors.primaryColor,
                child: SizedBox(
                    height: 45,
                    child: Center(
                        child: Text(
                      MyStrings.logOut,
                      style: textTheme.headlineMedium,
                    ))),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ));
  }
}
