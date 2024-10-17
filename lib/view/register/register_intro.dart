import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/controller/register_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:validators/validators.dart';

// ignore: must_be_immutable
class RegisterIntro extends StatelessWidget {
  RegisterIntro({Key? key}) : super(key: key);

  var registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.images.tcbot.path,
              height: Dimens.xlarge + 36,
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.medium),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: MyStrings.welcom,
                  style: textTheme.headlineMedium,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Dimens.large),
              child: ElevatedButton(
                onPressed: () {
                  _showEmailBottomSheet(context, size, textTheme);
                },
                child: Text(MyStrings.letsGo),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    // ignore: prefer_typing_uninitialized_variables
    var isValidate;
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: SolidColors.blackColor,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 2,
            decoration: BoxDecoration(
              color: SolidColors.lightIcon,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimens.large - 2),
                topRight: Radius.circular(Dimens.large - 2),
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MyStrings.insertYourEmail,
                  style: textTheme.headlineMedium,
                ),
                Padding(
                  padding: EdgeInsets.all(Dimens.medium + 8),
                  child: TextFormField(
                    controller: registerController.emailTextEditingController,
                    onChanged: (value) {
                      debugPrint(value +
                          MyStrings.isEmail +
                          isEmail(value).toString());
                      isValidate = EmailValidator.validate(
                          registerController.emailTextEditingController.text);
                    },
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: MyStrings.tecEmail,
                      hintStyle: textTheme.headlineSmall,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() async {
                    if (registerController
                        .emailTextEditingController.text.isEmpty) {
                      Get.snackbar(MyStrings.error, MyStrings.enterEmaile);
                    } else {
                      if (isValidate) {
                        registerController.register();
                        Navigator.pop(context);
                        _activateCodeBottomSheet(context, size, textTheme);
                      } else {
                        Get.snackbar(
                            MyStrings.error, MyStrings.formatEmailNotCorrect);
                      }
                    }
                  }),
                  child: Text(MyStrings.continuation),
                ),
              ],
            )),
          ),
        );
      }),
    );
  }

  Future<dynamic> _activateCodeBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: ((context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: size.height / 2,
              decoration: BoxDecoration(
                color: SolidColors.lightIcon,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimens.large - 2),
                  topRight: Radius.circular(Dimens.large - 2),
                ),
              ),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        MyStrings.activateCode,
                        style: textTheme.headlineMedium,
                      ),
                      Padding(
                        padding: EdgeInsets.all(Dimens.medium + 8),
                        child: TextField(
                          controller: registerController
                              .activeCodeTextEditingController,
                          onChanged: (value) {
                            debugPrint(value +
                                MyStrings.isEmail +
                                isEmail(value).toString());
                          },
                          style: textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: MyStrings.stars,
                              hintStyle: textTheme.headlineSmall),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: (() {
                            registerController.verify();
                          }),
                          child: Text(MyStrings.continuation))
                    ]),
              ),
            ),
          );
        }));
  }
}
