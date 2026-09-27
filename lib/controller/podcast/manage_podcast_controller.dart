import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/constant/api_key_constants.dart';
import 'package:tec/constant/commands.dart';
import 'package:tec/controller/file_controller.dart';
import 'package:tec/models/podcast_model.dart';
import 'package:tec/models/podcasts_file_model.dart';
import 'package:tec/services/dio_service.dart';
import '../../constant/storage_const.dart';

class ManagePodcastController extends GetxController {
  RxList<PodcastModel> podcastModel = RxList.empty();
RxInt currentHourValue = 0.obs;
  RxInt currentMinuteValue = 0.obs;
  RxInt currentSecondeValue = 0.obs;
  Rx<PodcastsFileModel> podcastFileModel =
      PodcastsFileModel("اسم پادکست اینجا قرار میگیره").obs;

  // var selectedTime = TimeOfDay.now().replacing(hour: 0,minute: 0).obs;
  RxBool loading = false.obs;
  TextEditingController titleTextEditingController = TextEditingController();
  

  RxInt? input = 0.obs;
  var userId = '';
  var catId = '';

  @override
  void onInit() {
    super.onInit();
    getManagedPodcasts();
  }

  getManagedPodcasts() async {
    loading.value = true;
    try {
      var uId = GetStorage().read(StorageKey.userId) ?? "1";
      var response = await DioService()
          .getMethod(ApiUrlConstant.PublishedByMePodcast + uId.toString());

      if (response != null && response.statusCode == 200 && response.data != null) {
        podcastModel.clear();
        for (var element in response.data) {
          podcastModel.add(PodcastModel.fromJson(element));
        }
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }

  updateTitle() {
    podcastFileModel.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }

  titlePodcast() async {
    if (titleTextEditingController.text.trim().isEmpty) {
      Get.snackbar('خطا', 'لطفاً عنوان پادکست را وارد کنید');
      return;
    }
    loading.value = true;
    try {
      Map<String, dynamic> map = {
        ApiPodcastTitleKyConstants.userId: GetStorage().read(StorageKey.userId),
        ApiPodcastTitleKyConstants.catId: catId,
        ApiPodcastTitleKyConstants.title: titleTextEditingController.text,
        ApiPodcastTitleKyConstants.command: Commands.storTitle,
      };
      var response =
          await DioService().postMethod(map, ApiUrlConstant.postPodcast);
      if (response != null && response.statusCode == 200) {
        Get.snackbar('موفقیت', 'عنوان پادکست با موفقیت ثبت شد');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }

  filePodcast() async {
    var fileController = Get.find<FilePickerController>();
    if (fileController.file.value.path == null) {
      return;
    }
    loading.value = true;
    try {
      Map<String, dynamic> map = {
        ApiPodcastFileKyConstants.title: podcastFileModel.value.title,
        ApiPodcastFileKyConstants.file:
            await dio.MultipartFile.fromFile(fileController.file.value.path!),
        ApiPodcastFileKyConstants.podcastId: podcastFileModel.value.podcastId,
        ApiPodcastFileKyConstants.command: Commands.storFile,
        ApiPodcastFileKyConstants.length: podcastFileModel.value.lenght,
      };
      await DioService().postMethod(map, ApiUrlConstant.postPodcast);
    } catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }

  UpdatePodcast() async {
    var fileController = Get.find<FilePickerController>();
    if (fileController.file.value.path == null) {
      Get.snackbar('خطا', 'لطفاً فایل را انتخاب کنید');
      return;
    }
    loading.value = true;
    try {
      Map<String, dynamic> map = {
        ApiPodcastUpdateKyConstants.image:
            await dio.MultipartFile.fromFile(fileController.file.value.path!),
        ApiPodcastUpdateKyConstants.file: podcastFileModel.value.file,
        ApiPodcastUpdateKyConstants.podcastId: podcastFileModel.value.podcastId,
        ApiPodcastUpdateKyConstants.command: Commands.storUpdate,
        ApiPodcastUpdateKyConstants.userId: GetStorage().read(StorageKey.userId),
      };
      var response =
          await DioService().postMethod(map, ApiUrlConstant.postPodcast);
      if (response != null && response.statusCode == 200) {
        Get.snackbar('موفقیت', 'پادکست با موفقیت بروزرسانی شد');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      loading.value = false;
    }
  }
}
