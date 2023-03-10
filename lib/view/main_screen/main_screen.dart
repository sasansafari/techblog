import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/decrations.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/main_screen/home_screen.dart';
import 'package:tec/view/main_screen/profile_screen.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../component/searchBar.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  RxInt selectedPageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: SolidColors.scaffoldBg,
          child: Padding(
            padding: EdgeInsets.only(
                right: Dimens.bodyMargin, left: Dimens.bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                    child: Center(
                  child: Image.asset(
                    Assets.images.logo.path,
                    scale: 3,
                  ),
                )),
                ListTile(
                  title: Text(
                    "پروفایل کاربری",
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {
                    _key.currentState!.closeDrawer();
                    selectedPageIndex.value = 1;
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "درباره تک‌بلاگ",
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "اشتراک گذاری تک بلاگ",
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () async {
                    await Share.share(MyStrings.shareText);
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "تک‌بلاگ در گیت هاب",
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {
                    myLaunchUrl(MyStrings.techBlogGithubUrl);
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: SolidColors.scaffoldBg,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: (() {
                  _key.currentState!.openDrawer();
                }),
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                Assets.images.logo.path,
                height: size.height / 13.6,
              ),
               // IconButton(
               //  icon: Icon(Icons.search , color: Colors.black,),
               //  onPressed: (){
               //    showSearch(context: context, delegate:CustomSearchDelegate());
               //  },
               //   ),
              IconButton(
                onPressed: () {
                  // method to show the search bar
                  showSearch(
                      context: context,
                      // delegate to customize the search bar
                      delegate: CustomSearchDelegate()
                  );
                },
                icon: const Icon(Icons.search , color: Colors.black,),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: Obx(
              () => IndexedStack(
                index: selectedPageIndex.value,
                children: [
                  HomeScreen(
                      size: size,
                      textTheme: textTheme,
                      bodyMargin: Dimens.bodyMargin), //0
                  const ProfileScreen() //1
                ],
              ),
            )),
            BottomNavigation(
              size: size,
              bodyMargin: Dimens.bodyMargin,
              changeScreen: (int value) {
                selectedPageIndex.value = value;
              },
              selectedScreen: selectedPageIndex,
            ),
          ],
        ),
      ),
    );
  }
}

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
              EdgeInsets.only(right: bodyMargin, left: bodyMargin, bottom: 10),
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
                          ? Colors.white
                          : Colors.grey[400],
                    ),
                  ),
                  IconButton(
                      onPressed: (() {
                        registerController.toggleLogin();
                      }),
                      icon: ImageIcon(
                        Image.asset(Assets.icons.write.path).image,
                        color: Colors.white,
                        size: 35,
                      )),
                  ZoomTapAnimation(
                      onTap: () => changeScreen(1),
                      child: ImageIcon(
                        Image.asset(Assets.icons.user.path).image,
                        size: selectedScreen.value == 1 ? 26 : 24,
                        color: selectedScreen.value == 1
                            ? Colors.white
                            : Colors.grey[400],
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
