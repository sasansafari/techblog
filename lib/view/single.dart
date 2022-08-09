import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:tec/component/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/component/my_strings.dart';
import 'package:tec/controller/home_screen_controller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/fake_data.dart';

 class Single extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return   SafeArea(
            child: Scaffold(
              backgroundColor: SolidColors.scafoldBg,
          body: Column(
            children: [
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "",
                    imageBuilder: ((context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                          foregroundDecoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: GradiantColors.blogPost)),
                        )),
                    placeholder: ((context, url) => const loading()),
                    errorWidget: ((context, url, error) =>
                        Image.asset(Assets.images.singlePlaceHolder.path)),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("nothing"),
                        Row(
                          children: [
                            Text("things"),
                            const SizedBox(
                              width: 8,
                            ),
                            const Icon(
                              Icons.remove_red_eye_sharp,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(color: Colors.blue,)
            ],
          ),
        ) ); 
  }
}
