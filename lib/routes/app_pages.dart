import 'package:get/route_manager.dart';

import 'package:tec/binding.dart';
import 'package:tec/routes/app_routes.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/single.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
        name: TechBlogRoutes.homeScreen,
        page: () => const MainScreen(),
        binding: RegisterBinding()),
    GetPage(
        name: TechBlogRoutes.articleSingleScreen,
        page: () => Single(),
        binding: ArticleBinding())
  ];
}
