
import 'package:json_annotation/json_annotation.dart';

import 'BannerBean.dart';

part 'BannerResponse.g.dart';

@JsonSerializable()
class BannerResponse {
  List<BannerBean>? data;

  BannerResponse({this.data});

  factory BannerResponse.fromJson(Map<String, dynamic> json) => _$BannerResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BannerResponseToJson(this);
}


