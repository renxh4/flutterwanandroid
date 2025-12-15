
import 'package:dio/dio.dart';
import 'package:flutterwanandroid/model/HttpBinGetResponse.dart';
import 'package:flutterwanandroid/network/BaseDio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/BannerResponse.dart';

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

}



