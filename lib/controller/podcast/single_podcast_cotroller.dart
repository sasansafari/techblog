import 'dart:async';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/podcasts_file_model.dart';
import 'package:tec/services/dio_service.dart';

class SinglePodcastController extends GetxController {
  String? id;

  SinglePodcastController({this.id});

  RxBool loading = false.obs;
  RxList<PodcastsFileModel> podcastFileList = RxList();
  final player = AudioPlayer();
  List<AudioSource> playList = [];
  RxBool playState = false.obs;
  RxBool isLoopAll = false.obs;
  RxInt currentFileIndex = 0.obs;

  @override
  onInit() async {
    super.onInit();

    await getPodcastFiles();

    await player.setAudioSources(
      playList,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
  }

  getPodcastFiles() async {
    loading.value = true;

    var response = await DioService().getMethod(
      "${ApiUrlConstant.podcastFiles}$id",
    );

    if (response.statusCode == 200) {
      for (var element in response.data["files"]) {
        var podcastFileModel = PodcastsFileModel.fromJson(element);

        podcastFileList.add(podcastFileModel);

        // تبدیل فایل به AudioSource
        playList.add(AudioSource.uri(Uri.parse(podcastFileModel.file!)));
      }
      loading.value = false;
    }
  }

  int? duration;
  RxInt selectedIndex = 0.obs;
  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> totalDuration = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;

  Timer? timer;
  startProgress() {
    const tick = Duration(seconds: 1);

    switch (player.duration) {
      case null:
        duration = 0;
        break;
      default:
        duration = player.duration!.inSeconds;
        break;
    }

    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timer = null;
    }

    timer = Timer.periodic(tick, (timer) {
      if (player.position.inSeconds == duration) {
        timer.cancel();
      }
      if (player.playing) {
        progressValue.value = player.position;
        bufferedValue.value = player.bufferedPosition;
      }
    });
  }

  void timerCheck() {
    const tick = Duration(seconds: 1);

    // if a timer is already running, cancel it before starting a new one
    if (timer != null && timer!.isActive) {
      timer!.cancel();
      timer = null;
    }

    timer = Timer.periodic(tick, (timer) async {
      // if the player is not playing, skip this tick
      if (!player.playing) return;

      // update current position and buffer progress for UI
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;
      totalDuration.value = player.duration ?? Duration.zero;

      // check if the current track has finished playing
      if (player.duration != null &&
          player.position.inSeconds >= player.duration!.inSeconds) {
        timer.cancel();

        // if loop mode is on, go to the next track or loop from start
        if (isLoopAll.value) {
          currentFileIndex.value =
              (currentFileIndex.value + 1) % playList.length;
          await player.seek(Duration.zero, index: currentFileIndex.value);
          await player.play();
        } else {
          // no loop mode → stop playback
          playState.value = false;
          await player.stop();
        }
      }
    });
  }

  setLoopMode() {
    if (isLoopAll.value) {
      isLoopAll.value = false;
      player.setLoopMode(LoopMode.off);
    } else {
      isLoopAll.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }
}
