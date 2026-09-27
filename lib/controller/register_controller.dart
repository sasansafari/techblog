import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/main_screen/bottom_navigation.dart';
import 'package:tec/view/register/register_intro.dart';

import '../constant/storage_const.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();
  var email = '';
  var userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register'
    };

    var response =
        await DioService().postMethod(map, ApiUrlConstant.postRegister);

    if (response != null && response.data != null) {
      email = emailTextEditingController.text;
      userId = response.data['user_id']?.toString() ?? '';
      debugPrint(response.toString());
    } else {
      Get.snackbar('خطا', 'خطا در ارتباط با سرور');
    }
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeTextEditingController.text,
      'command': 'verify'
    };

    debugPrint(map.toString());
    var response =
        await DioService().postMethod(map, ApiUrlConstant.postRegister);
    if (response == null || response.data == null) {
      Get.snackbar('خطا', 'خطا در برقراری ارتباط با سرور');
      return;
    }
    debugPrint(response.data.toString());
    var status = response.data['response'];

    switch (status) {
      case 'verified':
        BoxStorage.box.write(StorageKey.token, response.data['token']);
        BoxStorage.box.write(StorageKey.userId, response.data['user_id']);

        debugPrint("read token::: ${BoxStorage.box.read(StorageKey.token)}");
        debugPrint("read userId::: ${BoxStorage.box.read(StorageKey.userId)}");

        Get.offAllNamed(NamedRoute.routeMainScreen);
        break;
      case 'incorrect_code':
        Get.snackbar('خطا', 'کد فعالسازی غلط است');
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد فعالسازی منقضی شده است');
        break;
      default:
        Get.snackbar('خطا', 'خطایی رخ داده است');
        break;
    }
  }
    toggleLogin() {
   if (GetStorage().read(StorageKey.token) == null) {
    Get.to(RegisterIntro());
       } else {
       routeToWriteBottomSheet();
        }
     }
}
