import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tec/component/decrations.dart';
import 'package:tec/component/dimens.dart';
import 'package:tec/component/my_component.dart';
import 'package:tec/constant/my_colors.dart';
import 'package:tec/constant/my_strings.dart';
import 'package:tec/controller/podcast/single_podcast_cotroller.dart';
import 'package:tec/gen/assets.gen.dart';
import 'package:tec/models/podcast_model.dart';

class PodcastEmpty extends StatelessWidget {
  const PodcastEmpty({
    Key? key,
    required this.textTheme,
  }) : super(key: key);

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.images.emptyState.path,
            height: Dimens.xlarge + 36,
          ),
          Padding(
            padding: EdgeInsets.only(top: Dimens.medium),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: MyStrings.podcastEmpty,
                  style: textTheme.headlineMedium,
                )),
          ),
        ],
      ),
    );
  }
}

class PlayerManager extends StatelessWidget {
  const PlayerManager({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SinglePodcastController controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: Dimens.small,
      right: Dimens.bodyMargin,
      left: Dimens.bodyMargin,
      child: Container(
        height: Get.height / 7,
        decoration: MyDecorations.mainGradient,
        child: Padding(
          padding: EdgeInsets.all(Dimens.small),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Obx(
                () => ProgressBar(
                  timeLabelTextStyle: const TextStyle(color: Colors.white, fontSize: 12),
                  thumbColor: SolidColors.yelowColor,
                  baseBarColor: SolidColors.lightIcon.withOpacity(0.5),
                  progressBarColor: SolidColors.selectedPodCast,
                  buffered: controller.bufferedValue.value,
                  progress: controller.progressValue.value,
                  total: controller.totalDuration.value,
                  onSeek: (position) async {
                    await controller.player.seek(position);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (controller.player.hasNext) {
                        await controller.player.seekToNext();
                      }
                    },
                    child: const Icon(
                      Icons.skip_next,
                      color: SolidColors.lightIcon,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await controller.togglePlay();
                    },
                    child: Obx(
                      () => Icon(
                        controller.playState.value
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                        color: SolidColors.lightIcon,
                        size: Dimens.large + 18,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (controller.player.hasPrevious) {
                        await controller.player.seekToPrevious();
                      }
                    },
                    child: const Icon(
                      Icons.skip_previous,
                      color: SolidColors.lightIcon,
                      size: 30,
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.setLoopMode();
                      },
                      child: Icon(
                        Icons.repeat,
                        color: controller.isLoopAll.value
                            ? SolidColors.seeMore
                            : SolidColors.lightIcon,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Titlee extends StatelessWidget {
  const Titlee({
    Key? key,
    required this.podcastModel,
    required this.textheme,
  }) : super(key: key);

  final PodcastModel podcastModel;
  final TextTheme textheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.bodyMargin, vertical: Dimens.small),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          podcastModel.title ?? '',
          maxLines: 2,
          textAlign: TextAlign.start,
          style: textheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class FileList extends StatelessWidget {
  const FileList({
    Key? key,
    required this.controller,
    required this.textheme,
  }) : super(key: key);

  final SinglePodcastController controller;
  final TextTheme textheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.bodyMargin, vertical: Dimens.small),
      child: Obx(
        () {
          if (controller.loading.value) {
            return const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: Loading()),
            );
          }
          if (controller.podcastFileList.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Text(
                  'قسمتی برای این پادکست ثبت نشده است',
                  style: textheme.headlineMedium,
                ),
              ),
            );
          }
          return ListView.separated(
            itemCount: controller.podcastFileList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.black12),
            itemBuilder: (context, index) {
              final file = controller.podcastFileList[index];
              return Obx(() {
                final isPlaying = controller.currentFileIndex.value == index && controller.playState.value;
                final isCurrent = controller.currentFileIndex.value == index;
                return InkWell(
                  onTap: () => controller.playFile(index),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      color: isCurrent ? SolidColors.primaryColor.withOpacity(0.08) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(
                                isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                                color: isCurrent ? SolidColors.primaryColor : SolidColors.seeMore,
                                size: 28,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  file.title ?? 'قسمت ${index + 1}',
                                  style: textheme.headlineMedium?.copyWith(
                                    color: isCurrent ? SolidColors.primaryColor : null,
                                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '${file.lenght ?? '0'}:00',
                          style: textheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              });
            },
          );
        },
      ),
    );
  }
}

class Writer extends StatelessWidget {
  const Writer({
    Key? key,
    required this.podcastModel,
    required this.textheme,
  }) : super(key: key);

  final PodcastModel podcastModel;
  final TextTheme textheme;

  @override
  Widget build(BuildContext context) {
    final publisherName = (podcastModel.publisher != null && podcastModel.publisher!.isNotEmpty)
        ? podcastModel.publisher!
        : 'ناشناس';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimens.bodyMargin, vertical: Dimens.small),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                image: Image.asset(Assets.images.profileAvatar.path).image,
                height: Dimens.xlarge - 14,
              ),
              SizedBox(width: Dimens.small),
              Text(
                publisherName,
                style: textheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          if (podcastModel.createdAt != null && podcastModel.createdAt!.isNotEmpty)
            Text(
              podcastModel.createdAt!,
              style: textheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
