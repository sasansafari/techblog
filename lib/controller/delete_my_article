import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec_blog_new/components/storage_const.dart';
import 'package:tec_blog_new/services/dio_service.dart';

class DeleteMyArticle extends GetxController {
  RxBool loading = true.obs;
  deletMyArticlePostMethode({required String articleId}) async {
    loading.value = false;
    Map<String, dynamic> map = {
      'article_id': articleId,
      'user_id': GetStorage().read(StorageConst.userId),
      'command': 'delete_article',
    };
    var response = await DioService().postMethode(
        url: 'https://techblog.sasansafari.com/Techblog/api/article/post.php',
        map: map);
    if (response.statusCode == 200) {
      loading.value = true;
      log('response data ::' + response.data.toString());
      Get.snackbar('', ' مقاله با موفقیت حذف گردید',
          backgroundColor: Colors.green, colorText: Colors.white);
    } else {
      loading.value = true;
      Get.snackbar('', 'خطا در حذف مقاله',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
