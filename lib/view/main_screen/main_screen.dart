import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/view/main_screen/bottom_navigation.dart';
import 'package:tec/view/main_screen/home_screen.dart';
import 'package:tec/view/main_screen/profile_screen.dart';
import '../../component/search_bar.dart';

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
                    MyStrings.userProfile,
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
                    MyStrings.aboutTec,
                    style: textTheme.headlineMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    MyStrings.shareTec,
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
                    MyStrings.tecIngithub,
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
                  color: SolidColors.blackColor,
                ),
              ),
              Image.asset(
                Assets.images.logo.path,
                height: size.height / 13.6,
              ),
              IconButton(
                onPressed: () {
                  // method to show the search bar
                  showSearch(
                      context: context,
                      // delegate to customize the search bar
                      delegate: CustomSearchDelegate());
                },
                icon: const Icon(
                  Icons.search,
                  color: SolidColors.blackColor,
                ),
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
