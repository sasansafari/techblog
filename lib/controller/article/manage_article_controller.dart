import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';

import '../../services/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxList<TagsModel> tagList = RxList.empty();
  RxBool Loading = false.obs;
  TextEditingController titleTextEditingController = TextEditingController();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
          'اینجا عنوان مقاله قرار میگیره ، یه عنوان جذاب انتخاب کن',
          """
من متن و بدنه اصلی مقاله هستم ، اگه میخوای من رو ویرایش کنی و یه مقاله جذاب بنویسی ، نوشته آبی رنگ بالا که نوشته "ویرایش متن اصلی مقاله" رو با انگشتت لمس کن تا وارد ویرایشگر بشی""",
          "")
      .obs;

  @override
  onInit() {
    super.onInit();
    getManagedArticle();
  }


  getManagedArticle() async {
    Loading.value = true;
    //TODO get userid from getStorage ApiConstant.getArticleList+userid
    // var response = await DioSevice().getMethod(ApiConstant.publishedByMe+GetStorage().read(StorageKey.userId));
    var response = await DioSevice().getMethod(ApiConstant.publishedByMe + "1");

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      articleList.clear();
      Loading.value = false;
    }
  }


  updateTitle(){
      articleInfoModel.update((val) {
        val!.title = titleTextEditingController.text;
      });
  }
}
