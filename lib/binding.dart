import 'package:get/get.dart';
import 'package:tec/controller/list_article_controller.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/controller/single_article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ListArcticleController());

    Get.lazyPut(() => SingleArcticleController());
  }
}



class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(RegisterController());
 
  }
}
