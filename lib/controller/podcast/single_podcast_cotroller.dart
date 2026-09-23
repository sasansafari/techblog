import 'dart:async';
import 'dart:developer' as developer show log;

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tec/constant/api_constant.dart';
import 'package:tec/models/podcast_model.dart';
import 'package:tec/models/podcasts_file_model.dart';
import 'package:tec/services/dio_service.dart';

class SinglePodcastController extends GetxController {
  dynamic id;

  SinglePodcastController({this.id});

  RxBool loading = false.obs;
  RxList<PodcastsFileModel> podcastFileList = RxList();
  final player = AudioPlayer();
  late ConcatenatingAudioSource playList;
  RxBool playState = false.obs;
  RxBool isLoopAll = false.obs;
  RxInt currentFileIndex = 0.obs;

  int? duration;
  RxInt selectedIndex = 0.obs;
  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> totalDuration = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;
  Timer? timer;

  @override
  onInit() async {
    super.onInit();
    if (id == null) {
      if (Get.arguments is PodcastModel) {
        id = (Get.arguments as PodcastModel).id;
      } else if (Get.arguments != null) {
        id = Get.arguments.toString();
      }
    }

    playList = ConcatenatingAudioSource(useLazyPreparation: true, children: []);

    player.durationStream.listen((d) {
      if (d != null) {
        totalDuration.value = d;
      }
    });

    player.playerStateStream.listen((state) {
      playState.value = state.playing;
    });

    await getPodcastFiles();
    if (playList.length > 0) {
      await player.setAudioSource(playList,
          initialIndex: 0, initialPosition: Duration.zero);
    }
  }

  getPodcastFiles() async {
    loading.value = true;
    podcastFileList.clear();

    if (id == null) {
      loading.value = false;
      return;
    }

    var response =
        await DioService().getMethod(ApiUrlConstant.podcastFiles + id.toString());

    if (response != null &&
        response.statusCode == 200 &&
        response.data != null &&
        response.data["files"] != null) {
      for (var element in response.data["files"]) {
        var podcastFileModel = PodcastsFileModel.fromJson(element);
        podcastFileList.add(podcastFileModel);
        if (podcastFileModel.file != null) {
          playList.add(AudioSource.uri(Uri.parse(podcastFileModel.file!)));
        }
      }
    }
    loading.value = false;
  }

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

    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }
    timer = Timer.periodic(tick, (timer) {
      if (player.position.inSeconds == duration) {
        timer.cancel();
      }
      if (player.playing) {
        progressValue.value = player.position;

        bufferedValue.value = player.bufferedPosition;
        developer.log('TIMER :: ${progressValue.value}');
      }
    });
  }

  timerCheck() {
    if (player.playing) {
      startProgress();
    } else {
      timer?.cancel();
      timer = null;
      progressValue.value = Duration.zero;
      bufferedValue.value = Duration.zero;
    }
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

  @override
  void onClose() {
    timer?.cancel();
    player.dispose();
    super.onClose();
  }
}
