class TagsModel {
  String? id;
  String? title;

  TagsModel({
      this.id,
      this.title,
  });

  TagsModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
  }
}
