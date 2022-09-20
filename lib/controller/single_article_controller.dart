import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/single.dart';

class SingleArcticleController extends GetxController {
  RxBool loading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> releatedList = RxList();

  getArticleInfo(var id) async {
    articleInfoModel = ArticleInfoModel().obs;
     Get.to(Single());

    loading.value = true;
    var userId = '';
    debugPrint(ApiConstant.baseUrl +
        'article/get.php?command=info&id=$id&user_id=$userId');
    //TODO user id is hard code

    var response = await DioService().getMethod(ApiConstant.baseUrl +
        'article/get.php?command=info&id=$id&user_id=$userId');

    if (response.statusCode == 200) {
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);
       loading.value = false;

    }

    tagList.clear();
    response.data['tags'].forEach((element) {
      tagList.add(TagsModel.fromJson(element));
    });

    releatedList.clear();
    response.data['related'].forEach((element) {
      releatedList.add(ArticleModel.fromJson(element));

    });

  }


 
 
}
