import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:get/get.dart';
import 'package:tec/route_manager/names.dart';

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
          padding: EdgeInsets.only(top: Dimens.medium + 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Assets.images.profileAvatar.path,
                height: Dimens.xlarge + 36,
              ),
              SizedBox(
                height: Dimens.small + 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ImageIcon(
                    Image.asset(Assets.icons.bluePen.path).image,
                    color: SolidColors.seeMore,
                  ),
                  SizedBox(
                    width: Dimens.small,
                  ),
                  Text(
                    MyStrings.imageProfileEdit,
                    style: textTheme.displaySmall,
                  )
                ],
              ),
              SizedBox(
                height: Dimens.xlarge - 4,
              ),
              Text(
                MyStrings.nameFatemeAmiri,
                style: textTheme.headlineMedium,
              ),
              Text(
                MyStrings.gmailFatemeAmiri,
                style: textTheme.headlineMedium,
              ),
              SizedBox(
                height: Dimens.large + 8,
              ),
              TechDivider(size: size),
              InkWell(
                onTap: (() {
                  //یه چیزی اجرا بشه
                }),
                splashColor: SolidColors.primaryColor,
                child: SizedBox(
                    height: Dimens.large + 13,
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
                    height: Dimens.large + 13,
                    child: Center(
                        child: Text(
                      MyStrings.myFavPodcast,
                      style: textTheme.headlineMedium,
                    ))),
              ),
              TechDivider(size: size),
              InkWell(
                onTap: (() {
                  logOut();
                }),
                splashColor: SolidColors.primaryColor,
                child: SizedBox(
                    height: Dimens.large + 13,
                    child: Center(
                        child: Text(
                      MyStrings.logOut,
                      style: textTheme.headlineMedium,
                    ))),
              ),
              SizedBox(
                height: Dimens.xlarge - 4,
              ),
            ],
          ),
        ));
  }
}

logOut() {
  Get.defaultDialog(
    title: MyStrings.nameFatemeAmiri,
    titleStyle: const TextStyle(color: SolidColors.scaffoldBg),
    backgroundColor: SolidColors.primaryColor,
    content: Text(
      MyStrings.areYouSureExit,
      style: const TextStyle(color: SolidColors.scaffoldBg),
    ),
    radius: Dimens.small,
    cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text(MyStrings.cancel)),
    confirm: ElevatedButton(
        onPressed: () {
          if (GetStorage().read(StorageKey.token) == null) {
            Get.back();
            Get.snackbar(MyStrings.error, MyStrings.youAlreadyLeft);
          } else {
            BoxStorage.box.erase();
            Get.offNamed(NamedRoute.profileScreen);
          }
        },
        child: Text(MyStrings.exit)),
  );
}
