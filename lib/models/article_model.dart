import 'package:tec/constant/api_constant.dart';

class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? view;
  String? status;
  // String? isFavorite;
  String? createdAt;

  ArticleModel({
    this.id,
    this.title,
    this.image,
    this.catId,
    this.catName,
    this.author,
    this.view,
    this.status,
    // this.isFavorite,
    this.createdAt,
  });

  ArticleModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    image = ApiUrlConstant.hostDlUrl + element["image"];
    catId = element["cat_id"];
    catName = element["cat_name"];
    author = element["author"]??'ساسان صفری';
    view = element["view"];
    status = element["status"];
    createdAt = element["created_at"];
  }
}
