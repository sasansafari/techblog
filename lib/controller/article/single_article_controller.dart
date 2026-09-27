import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';

import '../../route_manager/names.dart';

class SingleArticleController extends GetxController {
  RxBool loading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel =
      ArticleInfoModel(null, null, null).obs;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> relatedList = RxList();

  getArticleInfo(var id) async {
    articleInfoModel = ArticleInfoModel(null, null, null).obs;

    Get.toNamed(NamedRoute.routeSingleArticle);

    loading.value = true;
    try {
      var userId = '';
      var url =
          '${ApiUrlConstant.baseUrl}article/get.php?command=info&id=$id&user_id=$userId';
      var response = await DioService().getMethod(url);

      if (response != null && response.statusCode == 200 && response.data != null) {
        articleInfoModel.value = ArticleInfoModel.fromJson(response.data);

        tagList.clear();
        if (response.data['tags'] != null) {
          response.data['tags'].forEach((element) {
            tagList.add(TagsModel.fromJson(element));
          });
        }

        relatedList.clear();
        if (response.data['related'] != null) {
          response.data['related'].forEach((element) {
            relatedList.add(ArticleModel.fromJson(element));
          });
        }
      }
    } finally {
      loading.value = false;
    }
  }
}
