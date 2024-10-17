import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/component/text_style.dart';
import 'package:tec/view/widgets/podcast_widgets.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/home_screen_controller.dart';
import '../../controller/podcast/manage_podcast_controller.dart';
import '../../route_manager/names.dart';

// ignore: must_be_immutable
class ManagePodcast extends StatelessWidget {
  ManagePodcast({Key? key}) : super(key: key);

  ManagePodcastController managePodcastController =
      Get.put(ManagePodcastController());
  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        appBar: appBar(MyStrings.managePodcast),
        body: Obx(() => managePodcastController.loading.value
            ? const Loading()
            : managePodcastController.podcastModel.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.fromLTRB(
                        0, Dimens.medium, Dimens.medium - 1, 0),
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: managePodcastController.podcastModel.length,
                      itemBuilder: ((context, index) {
                        // return Text(homeScreenController.topPodcast[index].title!,);
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(NamedRoute.singlePodcast,
                                arguments: managePodcastController
                                    .podcastModel[index]);
                          },
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: Dimens.xlarge + 36,
                                    width: Dimens.xlarge + 36,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                        Dimens.small,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: managePodcastController
                                            .podcastModel[index].poster!,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(Dimens.medium),
                                              ),
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.cover)),
                                        ),
                                        placeholder: ((context, url) =>
                                            const Loading()),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                          Icons.image_not_supported_outlined,
                                          size: Dimens.xlarge - 14,
                                          color: SolidColors.erorColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 0, 0, Dimens.bodyMargin / 1),
                                    child: Column(
                                      children: [
                                        Text(
                                          managePodcastController
                                              .podcastModel[index].title!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          managePodcastController
                                              .podcastModel[index].publisher!,
                                          style: subTextPodcastList,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                : PodcastEmpty(textTheme: textTheme)),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.all(Dimens.small),
          child: ElevatedButton(
              style: ButtonStyle(
                  fixedSize: WidgetStateProperty.all(
                      Size(Get.width / 3, Dimens.xlarge - 8))),
              onPressed: () {
                Get.toNamed(NamedRoute.singleManagePodcast);
              },
              child: Text(MyStrings.addNewPodcast)),
        ),
      ),
    );
  }
}
