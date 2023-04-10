import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/route_manager/names.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/main_screen/bottom_navigation.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/register/register_intro.dart';

import '../constant/my_colors.dart';
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

    email = emailTextEditingController.text;
    userId = response.data['user_id'];
    debugPrint(response.toString());
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
    debugPrint(response.data.toString());
    var status = response.data['response'];

    switch (status) {
      case 'verified':
        // var box = GetStorage();
        BoxStorage.box.write(StorageKey.token, response.data['token']);
        BoxStorage.box.write(StorageKey.userId, response.data['user_id']);

        debugPrint("read::: " + BoxStorage.box.read(StorageKey.token));
        debugPrint("read::: " + BoxStorage.box.read(StorageKey.userId));

        Get.offAll(const MainScreen());

        break;
      case 'incorrect_code':
        Get.snackbar('خطا', 'کد فعالسازی غلط است');
        break;
      case 'expired':
        Get.snackbar('خطا', 'کد فعالسازی منقضی شده است');
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
