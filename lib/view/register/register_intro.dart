import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:validators/validators.dart';

import 'package:tec/component/components.dart';
import 'package:tec/controller/controller.dart';
import 'package:tec/gen/assets.gen.dart';

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
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: MyStrings.welcom,
                  style: textTheme.headline4,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ElevatedButton(
                onPressed: () {
                  _showEmailBottomSheet(context, size, textTheme);
                },
                child: const Text("بزن بریم"),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, Size size, TextTheme textTheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: ((context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: size.height / 2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  MyStrings.insertYourEmail,
                  style: textTheme.headline4,
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TextField(
                    controller: registerController.emailTextEditingController,
                    onChanged: (value) {
                      print(value + " is Email : " + isEmail(value).toString());
                    },
                    style: textTheme.headline5,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "techblog@gmail.com",
                      hintStyle: textTheme.headline5,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (() async{
                    registerController.register();
                     Navigator.pop(context);
                   _activateCodeBottomSheet(context, size, textTheme);


                  }),
                  child: const Text("ادامه"),
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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        MyStrings.activateCode,
                        style: textTheme.headline4,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24),
                        child: TextField(
                          controller:
                              registerController.activeCodeTextEditingController,
                          onChanged: (value) {
                            print(value +
                                " is Email : " +
                                isEmail(value).toString());
                          },
                          style: textTheme.headline5,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "******",
                              hintStyle: textTheme.headline5),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: (() {
                            registerController.verify();
                       
                          }),
                          child: const Text("ادامه"))
                    ]),
              ),
            ),
          );
        }));
  }
}
