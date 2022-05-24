 
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/my_colors.dart';
import 'package:tec/my_strings.dart';

class RegisterIntro extends StatelessWidget{
  const RegisterIntro({Key? key}) : super(key: key);

  
  
  
  @override
  Widget build(BuildContext context) {
    
    var textTheme = Theme.of(context).textTheme;


    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Assets.images.tcbot.path,height: 100,),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: RichText(
                    textAlign: TextAlign.center,
                    
                    text: TextSpan(
                      text: MyStrings.welcom,
                      style: textTheme.headline4

                  )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: ElevatedButton(
                    onPressed: (){}, 
                    child: const Text("بزن بریم"),
                    style: ButtonStyle(
                      textStyle:  MaterialStateProperty.resolveWith((states){

                          if(states.contains(MaterialState.pressed)){

                            return textTheme.headline1;
                          }
                    
                       return textTheme.subtitle1;

                      }),

                      backgroundColor: MaterialStateProperty.resolveWith((states){

                          if(states.contains(MaterialState.pressed)){

                            return SolidColors.seeMore;
                          }
                    
                            return SolidColors.primeryColor;

                      }),

                    ),
                    
                    ),
                )
              
              ],
            ),
          ),

      )
    
    );
  }



}