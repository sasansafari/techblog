import 'package:get/get.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/controller/podcast/single_podcast_cotroller.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => ListArticleController());
    Get.lazyPut(() => SingleArticleController());
  }
}

class ArticleManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManageArticleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}

class SinglePodcastBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SinglePodcastController());
  }
}

class PodcastManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SinglePodcastController());
  }
}
