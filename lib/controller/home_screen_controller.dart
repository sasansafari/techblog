import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_model.dart';
import 'package:tec/models/podcast_model.dart';

import 'package:tec/models/poster_model.dart';
import 'package:tec/services/dio_service.dart';

class HomeScreenController extends GetxController {
  Rx<PosterModel>? poster ;
  RxList tagsList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcasts = RxList();

  @override
  onInit() {
    super.onInit();
    getHomeItems();
  }

  getHomeItems() async {
    var response = await DioSevice().getMethod(ApiConstant.getHomeItems);

    if (response.statusCode == 200) {



      response.data['top_visited'].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
      });

       response.data['top_podcasts'].forEach((element) {
        topPodcasts.add(PodcastModel.fromJson(element));
      });


 


     }
  }
}
