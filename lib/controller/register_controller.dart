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
  var user_id = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register'
    };

    var response = await DioSevice().postMethod(map, ApiConstant.postRsgister);

    email = emailTextEditingController.text;
    user_id = response.data['user_id'];
    print(response);
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': user_id,
      'code': activeCodeTextEditingController.text,
      'command': 'verify'
    };

    print(map);
    var response = await DioSevice().postMethod(map, ApiConstant.postRsgister);
    print(response.data);

    if (response.data['response'] == 'verified') {
      var box = GetStorage();
      box.write(token, response.data['token']);
      box.write(user_id, response.data['user_id']);


      print("read::: "+box.read(token));
      print("read::: "+box.read(user_id));

      Get.to(MainScreen());
    }else{

      log('erroe');
    }

  }
}
