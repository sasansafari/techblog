import 'package:get/get.dart';
import 'package:tec/controller/article/list_article_controller.dart';
import 'package:tec/controller/article/manage_article_controller.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/controller/article/single_article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    // ignore: todo
    // TODO: implement dependencies
    Get.put(ListArcticleController());

    Get.lazyPut(() => SingleArcticleController());
  }
}

class ArticleManagerBinding implements Bindings {
  @override
  void dependencies() {
    // ignore: todo
    // TODO: implement dependencies
    // Get.put(ManageArticleController());
    Get.put(ManageArticleController());

   }
}



class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    // ignore: todo
    // TODO: implement dependencies
    Get.put(RegisterController());
 
  }
}
