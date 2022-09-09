import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/main_screen/main_screen.dart';

import '../component/storage_const.dart';

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

    var response = await DioSevice().postMethod(map, ApiConstant.postRsgister);

    email = emailTextEditingController.text;
    userId = response.data['user_id'];
    debugPrint(response);
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeTextEditingController.text,
      'command': 'verify'
    };

    debugPrint(map.toString());
    var response = await DioSevice().postMethod(map, ApiConstant.postRsgister);
    debugPrint(response.data);

    if (response.data['response'] == 'verified') {
      var box = GetStorage();
      box.write(token, response.data['token']);
      box.write(userId, response.data['user_id']);


      debugPrint("read::: "+box.read(token));
      debugPrint("read::: "+box.read(userId));

      Get.to(const MainScreen());
    }else{

      log('erroe');
    }

  }
}
