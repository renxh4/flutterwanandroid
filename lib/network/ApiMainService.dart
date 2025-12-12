
import 'package:dio/dio.dart';
import 'package:flutterwanandroid/model/HttpBinGetResponse.dart';
import 'package:flutterwanandroid/network/BaseDio.dart';
import 'package:retrofit/retrofit.dart';

part 'ApiMainService.g.dart';

@RestApi()
abstract class ApiMainService {
  factory ApiMainService(String baseUrl,{Dio? dio}) {
    dio ??= BaseDio.create(baseUrl: baseUrl);
    return _ApiMainService(dio, baseUrl: baseUrl);
  }

  @GET("/get")
  Future<HttpBinGetResponse> pingGetModel();

}



