
import 'package:dio/dio.dart';
import 'package:flutterwanandroid/model/HttpBinGetResponse.dart';
import 'package:flutterwanandroid/network/BaseDio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/ArticleResponse.dart';
import '../model/BannerResponse.dart';
import '../model/article_models.dart';

part 'ApiWanService.g.dart';

@RestApi()
abstract class ApiWanService {
  factory ApiWanService() {
    var dio = BaseDio.create(baseUrl: "https://www.wanandroid.com");
    return _ApiWanService(dio);
  }

  static ApiWanService get instance => ApiWanService();

  @GET("/banner/json")
  Future<BannerResponse> banner();

  /// page 由外部传入，生成 /article/list/{page}/json
  @GET("/article/list/{page}/json")
  Future<ArticleListResponse> getArticleList(@Path("page") int page);

}



