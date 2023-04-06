import 'package:tec/constant/api_constant.dart';

class PodcastModel {
  String? id;
  String? title;
  String? poster;
  String? publisher;
  String? view;
  String? createdAt;

  PodcastModel();

  PodcastModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    poster = element["poster"] != null
        ? ApiUrlConstant.hostDlUrl + element["poster"]
        : '';
    publisher = element["author"];
    view = element["view"];
    createdAt = element["created_at"];
  }
}
