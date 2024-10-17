import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/fake_data/fake_data.dart';

class MyCats extends StatefulWidget {
  const MyCats({Key? key}) : super(key: key);

  @override
  State<MyCats> createState() => _MyCatsState();
}

class _MyCatsState extends State<MyCats> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    double bodyMargin = size.width / 10;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Dimens.large,
                  ),
                  SvgPicture.asset(
                    Assets.images.tcbot.path,
                    height: Dimens.xlarge + 36,
                  ),
                  SizedBox(
                    height: Dimens.medium,
                  ),
                  Text(
                    MyStrings.successfulRegistration,
                    style: textTheme.headlineMedium,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: MyStrings.nameAndFamilyName,
                      hintStyle: textTheme.headlineMedium,
                    ),
                  ),
                  SizedBox(
                    height: Dimens.large,
                  ),
                  Text(
                    MyStrings.chooseCats,
                    style: textTheme.headlineMedium,
                  ),
                  //taglist
                  Padding(
                    padding: EdgeInsets.only(top: Dimens.large),
                    child: SizedBox(
                      width: double.infinity,
                      height: Dimens.xlarge + 21,
                      child: GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: tagList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: Dimens.small - 3,
                                  mainAxisSpacing: Dimens.small - 3,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.3),
                          itemBuilder: ((context, index) {
                            return InkWell(
                              onTap: (() {
                                setState(() {
                                  if (!selectedTags.contains(tagList[index])) {
                                    selectedTags.add(tagList[index]);
                                  } else {
                                    debugPrint("${tagList[index].title} exist");
                                  }
                                });
                              }),
                              child:
                                  MainTags(textTheme: textTheme, index: index),
                            );
                          })),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.medium,
                  ),
                  Image.asset(
                    Assets.icons.downCatArrow.path,
                    scale: 3,
                  ),
                  //selected Tags
                  Padding(
                    padding: EdgeInsets.only(top: Dimens.large),
                    child: SizedBox(
                      width: double.infinity,
                      height: Dimens.xlarge + 21,
                      child: GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: selectedTags.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          crossAxisCount: 2,
                          childAspectRatio: 0.2,
                        ),
                        itemBuilder: ((context, index) {
                          return Container(
                            height: Dimens.xlarge - 4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Dimens.medium + 8)),
                              color: SolidColors.surface,
                            ),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(Dimens.medium,
                                  Dimens.small, Dimens.small, Dimens.small),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Dimens.small,
                                  ),
                                  Text(
                                    selectedTags[index].title,
                                    style: textTheme.headlineMedium,
                                  ),
                                  InkWell(
                                    onTap: (() {
                                      setState(() {
                                        selectedTags.removeAt(index);
                                      });
                                    }),
                                    child: const Icon(
                                      CupertinoIcons.delete,
                                      color: SolidColors.greyColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
