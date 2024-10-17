import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/api_key_constants.dart';
import 'package:tec/constant/commands.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/constant/storage_const.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/tags_model.dart';

import '../../services/dio_service.dart';
import '../file_controller.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxList<TagsModel> tagList = RxList.empty();
  RxBool loading = false.obs;
  TextEditingController titleTextEditingController = TextEditingController();
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel(
    MyStrings.titltArrticle,
    MyStrings.editOrginalTextArticle,
    "",
  ).obs;

  @override
  onInit() {
    super.onInit();
    getManagedArticle();
  }

  getManagedArticle() async {
    loading.value = true;
    var response =
        await DioService().getMethod("${ApiUrlConstant.publishedByMe}1");

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
  }

  updateTitle() {
    articleInfoModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }

  storeArticle() async {
    var fileController = Get.find<FilePickerController>();
    loading.value = true;
    Map<String, dynamic> map = {
      ApiArticleKeyConstant.title: articleInfoModel.value.title,
      ApiArticleKeyConstant.content: articleInfoModel.value.content,
      ApiArticleKeyConstant.catId: articleInfoModel.value.catId,
      ApiArticleKeyConstant.userId: GetStorage().read(StorageKey.userId),
      ApiArticleKeyConstant.image:
          await dio.MultipartFile.fromFile(fileController.file.value.path!),
      ApiArticleKeyConstant.command: Commands.store,
      ApiArticleKeyConstant.tagList: "[]"
    };
    // ignore: unused_local_variable
    var response =
        await DioService().postMethod(map, ApiUrlConstant.articlePost);
    loading.value = false;
  }
}
