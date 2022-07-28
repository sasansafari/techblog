class PosterModel {
  String? id;
  String? title;
  String? image;
 

  PosterModel({
    required this.id,
    required this.title,
    required this.image,
 
  });

  PosterModel.fromJson(Map<String, dynamic> element) {
     id  = element["id"];
     title=element["title"];
     image=element["image"];
 
  }
}
 