
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tec/models/fake_data.dart';
import 'package:tec/my_colors.dart';
import 'package:tec/my_strings.dart';

import '../gen/assets.gen.dart';
import '../my_component.dart';

class profileScreen extends StatelessWidget {

  const profileScreen({
    Key? key,
    required this.size,
    required this.textTheme,
    required this.bodyMargin,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
     physics: const BouncingScrollPhysics(),
     child:Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
          Image(image: Assets.images.profileAvatar,height: 100,),
          const SizedBox(height: 12,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(Assets.icons.bluePen,color: solidColors.seeMore,),
              SizedBox(width: 8,),
              Text(
                myStrings.imageProfileEdit,
                style: textTheme.headline3,
              )
            ],
          ),
          const SizedBox(height: 60,),
          Text("فاطمه امیری",style: textTheme.headline4,),
          Text("fatemeamiri@gmail.com",style: textTheme.headline4,),
          const SizedBox(height: 40,),
          techDivider(size: size),
          InkWell(
            onTap: (() {
              //یه چیزی اجرا بشه
            }),
            splashColor: solidColors.primeryColor,
            child: SizedBox(
              height: 45,
              child: Center(child: Text(myStrings.myFavBlog ,style: textTheme.headline4,))),
          ),
          techDivider(size: size),
          InkWell(
            onTap: (() {
              //یه چیزی اجرا بشه
            }),
            splashColor: solidColors.primeryColor,
            child: SizedBox(
              height: 45,
              child: Center(child: Text(myStrings.myFavPodcast ,style: textTheme.headline4,))),
          ),
          techDivider(size: size),
          InkWell(
            onTap: (() {
              //یه چیزی اجرا بشه
            }),
            splashColor: solidColors.primeryColor,
            child: SizedBox(
              height: 45,
              child: Center(child: Text(myStrings.logOut ,style: textTheme.headline4,))),
          ),
          const SizedBox(height: 60,),

       ],
     )
     
     );
  }
}


