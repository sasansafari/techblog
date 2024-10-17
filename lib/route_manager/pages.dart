import 'package:get/get.dart';
import 'package:tec/route_manager/binding.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/view/articles/manage_article.dart';
import 'package:tec/view/articles/single.dart';
import 'package:tec/view/articles/single_manage_article.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/podcast/manage_podcast.dart';
import 'package:tec/view/podcast/single_manage_podcast.dart';
import 'package:tec/view/podcast/single_podcast.dart';
import 'package:tec/view/splash_screen.dart';

class Pages {
  Pages._();

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: NamedRoute.initialRoute,
      page: () => const SplashScreen(),
    ),
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
    GetPage(
        name: NamedRoute.singlePodcast,
        page: () => PodcastSingle(),
        binding: SinglePodcastBinding()),
    GetPage(
      name: NamedRoute.singleManagePodcast,
      page: () => SingleManagePodcast(),
      binding: PodcastManagerBinding(),
    ),
    GetPage(
      name: NamedRoute.podcastManageList,
      page: () => ManagePodcast(),
      binding: PodcastManagerBinding(),
    ),
  ];
}
