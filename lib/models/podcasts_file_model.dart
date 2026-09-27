import 'package:tec/constant/api_constant.dart';

class PodcastsFileModel {
  String? id;
  String? podcastId;
  String? file;
  String? title;
  String? lenght;

  PodcastsFileModel(this.title);

  PodcastsFileModel.fromJson(Map<String, dynamic> element) {
    id = element["id"]?.toString();
    podcastId = element["podcast_id"]?.toString();
    String? rawFile = element["file"]?.toString();
    if (rawFile != null && rawFile.isNotEmpty) {
      file = rawFile.startsWith("http") ? rawFile : ApiUrlConstant.hostDlUrl + rawFile;
    }
    title = element["title"]?.toString() ?? '';
    lenght = element["length"]?.toString() ?? '0';
  }
}
