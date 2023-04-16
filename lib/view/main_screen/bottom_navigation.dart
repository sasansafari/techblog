import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/decrations.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/view/register/register_intro.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({
    Key? key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
    required this.selectedScreen,
  }) : super(key: key);

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;
  final RxInt selectedScreen;

  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        height: size.height / 10,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: GradientColors.bottomNavBackground,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(right: bodyMargin, left: bodyMargin, bottom: Dimens.small+2),
          child: Container(
            height: size.height / 8,
            decoration: MyDecorations.mainGradient,
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ZoomTapAnimation(
                    onTap: () => changeScreen(0),
                    child: ImageIcon(
                      Image.asset(Assets.icons.home.path).image,
                      size: selectedScreen.value == 0 ? 26 : 24,
                      color: selectedScreen.value == 0
                          ? SolidColors.lightIcon
                          : SolidColors.greyColor,
                    ),
                  ),
                  IconButton(
                      onPressed: (() {
                        registerController.toggleLogin();
                      }),
                      icon: ImageIcon(
                        Image.asset(Assets.icons.write.path).image,
                        color: SolidColors.lightIcon,
                        size: Dimens.large+3,
                      )),
                  ZoomTapAnimation(
                      onTap: () => changeScreen(1),
                      child: ImageIcon(
                        Image.asset(Assets.icons.user.path).image,
                        size: selectedScreen.value == 1 ? 26 : 24,
                        color: selectedScreen.value == 1
                        ? SolidColors.lightIcon
                          : SolidColors.greyColor,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

  routeToWriteBottomSheet() {
    Get.bottomSheet(Container(
      height: Get.height / 3,
      decoration:  BoxDecoration(
          color: SolidColors.lightText,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimens.medium+4), topRight: Radius.circular(Dimens.medium+4))),
      child: Padding(
        padding:  EdgeInsets.all(Dimens.medium),
        child: Column(children: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.images.tcbot.path,
                height: Dimens.large+8,
              ),
               SizedBox(
                width: Dimens.small,
              ),
               Text(MyStrings.shareKnowledge)
            ],
          ),
           SizedBox(
            height: Dimens.small,
          ),
           Text(MyStrings.gigTech),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (() {
                  // debugPrint("write article");
                  Get.toNamed(NamedRoute.manageArticle);
                }),
                child: Container(
                  color: SolidColors.lightIcon,
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.icons.writeArticleIcon.path,
                        height: Dimens.large,
                      ),
                       SizedBox(
                        width: Dimens.small,
                      ),
                       Text(MyStrings.titleAppBarManageArticle)
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: (() {
                  Get.toNamed(NamedRoute.podcastManageList);
                  debugPrint(MyStrings.writePodcast);
                }),
                child: Container(
                  color: SolidColors.lightIcon,
                  child: Row(
                    children: [
                      Image.asset(
                        Assets.icons.writePodcastIcon.path,
                        height: Dimens.large,
                      ),
                       SizedBox(
                        width: Dimens.small,
                      ),
                       Text(MyStrings.ManagePodcast)
                    ],
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    ));
  }
