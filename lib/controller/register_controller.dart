import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/services/dio_service.dart';
import 'package:tec/view/main_screen/main_screen.dart';
import 'package:tec/view/register/register_intro.dart';

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
    var response = await DioSevice().postMethod(map, ApiConstant.postRsgister);
    debugPrint(response.data.toString());
    var status = response.data['response'];

    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write(token, response.data['token']);
        box.write(userId, response.data['user_id']);

        debugPrint("read::: " + box.read(token));
        debugPrint("read::: " + box.read(userId));

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
    if (GetStorage().read(token) == null) {
      Get.to(RegisterIntro());
    } else {
      openBottomSheet();
    }
  }

  void openBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height/3,
        decoration: const BoxDecoration(
        color: Colors.white,
             borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.images.tcbot.path,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text("دونسته هات رو با بقیه به اشتراک بذار ..."),

                ],
              ),
              const SizedBox(height: 16,),
                              const Text("""فکر کن !!  اینجا بودنت به این معناست که یک گیک تکنولوژی هستی
دونسته هات رو با  جامعه‌ی گیک های فارسی زبان به اشتراک بذار.."""),
SizedBox(height: 32,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Image.asset(Assets.icons.writeArticle.path,height: 32,),                const SizedBox(
                    width: 8,
                  ),
                    Text("مدیریت مقاله ها"),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(Assets.icons.writeMicrophone.path,height: 32,),                const SizedBox(
                    width: 8,
                  ),
                    Text("مدیریت مقاله ها"),
                  ],
                )
              ],
            )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,

   
    );
  }
}
