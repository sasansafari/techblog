// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:tec/constant/api_constant.dart';

class PodcastModel {
  String? id;
  String? title;
  String? poster;
  String? publisher;
  String? view;
  String? createdAt;
  PodcastModel({
    required this.id,
    required this.title,
    required this.poster,
    required this.publisher,
    required this.view,
    required this.createdAt,
  });


  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      poster: (json['poster'] != null && json['poster'].toString().startsWith('http'))
          ? json['poster']
          : ApiUrlConstant.hostDlUrl + (json['poster'] ?? ''),
      publisher: (json['publisher'] != null && json['publisher'].toString().isNotEmpty)
          ? json['publisher']
          : (json['author'] != null && json['author'].toString().isNotEmpty)
              ? json['author']
              : 'ناشناس',
      view: json['view']?.toString() ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
