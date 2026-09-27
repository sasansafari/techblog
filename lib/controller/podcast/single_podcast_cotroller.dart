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
  ConcatenatingAudioSource playList = ConcatenatingAudioSource(children: []);
  RxBool playState = false.obs;
  RxBool isLoopAll = false.obs;
  RxInt currentFileIndex = 0.obs;

  RxInt selectedIndex = 0.obs;
  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> totalDuration = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;
  Timer? timer;
  int? duration;

  final List<StreamSubscription> _subscriptions = [];

  @override
  void onInit() async {
    super.onInit();
    if (id == null && Get.arguments != null && Get.arguments is PodcastModel) {
      id = (Get.arguments as PodcastModel).id;
    }

    _subscriptions.add(player.playerStateStream.listen((state) {
      playState.value = state.playing;
    }));

    _subscriptions.add(player.positionStream.listen((pos) {
      progressValue.value = pos;
    }));

    _subscriptions.add(player.bufferedPositionStream.listen((buf) {
      bufferedValue.value = buf;
    }));

    _subscriptions.add(player.durationStream.listen((dur) {
      if (dur != null) {
        totalDuration.value = dur;
        duration = dur.inSeconds;
      }
    }));

    _subscriptions.add(player.currentIndexStream.listen((index) {
      if (index != null) {
        currentFileIndex.value = index;
      }
    }));

    if (id != null) {
      await getPodcastFiles();
    }
  }

  Future<void> getPodcastFiles() async {
    loading.value = true;
    try {
      var response =
          await DioService().getMethod(ApiUrlConstant.podcastFiles + id.toString());

      if (response != null && response.statusCode == 200 && response.data != null) {
        podcastFileList.clear();
        List<AudioSource> sources = [];
        for (var element in response.data["files"]) {
          var podcastFileModel = PodcastsFileModel.fromJson(element);
          podcastFileList.add(podcastFileModel);
          if (podcastFileModel.file != null && podcastFileModel.file!.isNotEmpty) {
            sources.add(AudioSource.uri(Uri.parse(podcastFileModel.file!)));
          }
        }
        if (sources.isNotEmpty) {
          playList = ConcatenatingAudioSource(children: sources);
          await player.setAudioSource(playList,
              initialIndex: 0, initialPosition: Duration.zero);
        }
      }
    } catch (e) {
      developer.log('Error fetching podcast files: $e');
    } finally {
      loading.value = false;
    }
  }

  Future<void> playFile(int index) async {
    if (index >= 0 && index < podcastFileList.length && playList.length > index) {
      try {
        currentFileIndex.value = index;
        await player.seek(Duration.zero, index: index);
        await player.play();
      } catch (e) {
        developer.log('Error playing file: $e');
      }
    }
  }

  Future<void> togglePlay() async {
    if (playList.length == 0) return;
    try {
      if (player.playing) {
        await player.pause();
      } else {
        await player.play();
      }
    } catch (e) {
      developer.log('Error toggling play: $e');
    }
  }

  startProgress() {
    // Kept for backward compatibility with external calls
  }

  timerCheck() {
    // Kept for backward compatibility with external calls
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
    for (var sub in _subscriptions) {
      sub.cancel();
    }
    _subscriptions.clear();
    timer?.cancel();
    player.stop();
    player.dispose();
    super.onClose();
  }
}
