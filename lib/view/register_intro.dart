import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/my_colors.dart';
import 'package:tec/my_strings.dart';

class RegisterIntro extends StatelessWidget {
  const RegisterIntro({Key? key}) : super(key: key);

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
                      text: MyStrings.welcom, style: textTheme.headline4)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: ElevatedButton(
                onPressed: () {


                    showModalBottomSheet(
                      
                      isScrollControlled: true,
                      
                      context: context, 
                    backgroundColor: Colors.transparent,
                    builder: ((context) {
                      return Padding(
                        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          height: size.height/2,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)
                            )
                          ),
                        child: Center(child: 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(MyStrings.insertYourEmail,style: textTheme.headline4,),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: TextField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "techblog@gmail.com",
                                  hintStyle: textTheme.headline5
                                ),
                              ),
                            )
                            ,ElevatedButton(onPressed: (() {
                              
                            }), child: Text("ادامه"))
                          
                          ],
                        )
                        ),
                     
                     
                        ),
                      );
                    })
                    );


                },
                child: const Text("بزن بریم"),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
