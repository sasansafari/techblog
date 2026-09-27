import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/services/dio_service.dart';

class ListArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    loading.value = true;
    try {
      var response = await DioService().getMethod(ApiUrlConstant.getArticleList);

      if (response != null && response.statusCode == 200 && response.data != null) {
        articleList.clear();
        response.data.forEach((element) {
          articleList.add(ArticleModel.fromJson(element));
        });
      }
    } finally {
      loading.value = false;
    }
  }

  getArticleListWithTagsId(String id) async {
    articleList.clear();
    loading.value = true;
    try {
      var url =
          "${ApiUrlConstant.baseUrl}article/get.php?command=get_articles_with_tag_id&tag_id=$id&user_id=";
      var response = await DioService().getMethod(url);

      if (response != null && response.statusCode == 200 && response.data != null) {
        articleList.clear();
        response.data.forEach((element) {
          articleList.add(ArticleModel.fromJson(element));
        });
      }
    } finally {
      loading.value = false;
    }
  }
}
