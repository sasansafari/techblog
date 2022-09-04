import 'package:get/get.dart';
import 'package:tec/component/api_constant.dart';
import 'package:tec/models/article_info_model.dart';
import 'package:tec/services/dio_service.dart';

class SingleArcticleController extends GetxController {
   
  RxBool loading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArticleInfoModel> articleInfoModel = ArticleInfoModel().obs;
  
  @override
  onInit() {
    super.onInit();
 
  }

  getArticleInfo() async {
    loading.value = true;
    var userId = '';
    print(ApiConstant.baseUrl+'article/get.php?command=info&id=$id&user_id=$userId');
    //TODO user id is hard code

    var response = await DioSevice().getMethod(ApiConstant.baseUrl+'article/get.php?command=info&id=$id&user_id=$userId');

    if (response.statusCode == 200) {
      
      articleInfoModel.value = ArticleInfoModel.fromJson(response.data);
      loading.value = false;
    }
  }


}
