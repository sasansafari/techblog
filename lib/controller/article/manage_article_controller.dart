import 'dart:developer';
import 'dart:ffi';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/commands.dart';
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
    loading.value = true;
    // ignore: todo
    //TODO get userid from getStorage ApiConstant.getArticleList+userid
    // var response = await DioSevice().getMethod(ApiConstant.publishedByMe+GetStorage().read(StorageKey.userId));
    var response = await DioSevice().getMethod(ApiUrlConstant.publishedByMe + "1");

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });

      loading.value = false;
    }
  }


  updateTitle(){
      articleInfoModel.update((val) {
        val!.title = titleTextEditingController.text;
      });
  }



storeArticle() async {
  

  var fileContollrt = Get.find<FilePickerController>();
  loading.value = true;
  Map<String, dynamic> map = {
      ApiArticleKeyConstant.title : articleInfoModel.value.title,
      ApiArticleKeyConstant.content : articleInfoModel.value.content,
      ApiArticleKeyConstant.catId :articleInfoModel.value.catId,
      ApiArticleKeyConstant.userId : GetStorage().read(StorageKey.userId),
      ApiArticleKeyConstant.image : await dio.MultipartFile.fromFile(fileContollrt.file.value.path!),
      ApiArticleKeyConstant.command : Commands.store,
      ApiArticleKeyConstant.tagList : "[]"
 
  };
  var response = await DioSevice().postMethod(map, ApiUrlConstant.articlePost);
  log(response.data.toString());
  loading.value = false;

}

}
