
import 'package:flutter/material.dart';
  import 'package:tec/my_colors.dart';
import 'package:tec/my_strings.dart';

import '../gen/assets.gen.dart';
import '../my_component.dart';

class ProfileScreen extends StatelessWidget {

  const ProfileScreen({
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
     child:Padding(
       padding: const EdgeInsets.only(top: 24
       ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
            Image(image: Assets.images.profileAvatar,height: 100,),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(Assets.icons.bluePen,color: SolidColors.seeMore,),
                const SizedBox(width: 8,),
                Text(
                  MyStrings.imageProfileEdit,
                  style: textTheme.headline3,
                )
              ],
            ),
            const SizedBox(height: 60,),
            Text("فاطمه امیری",style: textTheme.headline4,),
            Text("fatemeamiri@gmail.com",style: textTheme.headline4,),
            const SizedBox(height: 40,),
            TechDivider(size: size),
            InkWell(
              onTap: (() {
                //یه چیزی اجرا بشه
              }),
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                height: 45,
                child: Center(child: Text(MyStrings.myFavBlog ,style: textTheme.headline4,))),
            ),
            TechDivider(size: size),
            InkWell(
              onTap: (() {
                //یه چیزی اجرا بشه
              }),
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                height: 45,
                child: Center(child: Text(MyStrings.myFavPodcast ,style: textTheme.headline4,))),
            ),
            TechDivider(size: size),
            InkWell(
              onTap: (() {
                //یه چیزی اجرا بشه
              }),
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                height: 45,
                child: Center(child: Text(MyStrings.logOut ,style: textTheme.headline4,))),
            ),
            const SizedBox(height: 60,),

         ],
       ),
     )
     
     );
  }
}


