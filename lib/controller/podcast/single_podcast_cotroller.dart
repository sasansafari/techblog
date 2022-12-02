

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/podcasts_file_model.dart';
import 'package:tec/services/dio_service.dart';

class SinglePodcastController extends GetxController{

  var id;

  SinglePodcastController({this.id});

  RxBool loading  = false.obs;
  RxList<PodcastsFileModel> podcastFileList = RxList();

  getPodcastFiles() async {
    loading.value = true;

    var response = await DioSevice().getMethod(ApiUrlConstant.podcastFiles+id);

    if (response.statuCode==200) {

      for (var element in response.data["files"]) {
        podcastFileList.add(PodcastsFileModel.fromJson(element));
      }
      loading.value =false;  
    }


  }


}