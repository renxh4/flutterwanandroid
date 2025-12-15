import 'package:json_annotation/json_annotation.dart';

part 'BannerBean.g.dart';


@JsonSerializable()
class BannerBean {
  int? id;
  String? imagePath;
  String? title;
  String? url;
  String? desc;


  BannerBean({this.id, this.imagePath, this.title, this.url, this.desc});

  factory BannerBean.fromJson(Map<String, dynamic> json) => _$BannerBeanFromJson(json);
  Map<String, dynamic> toJson() => _$BannerBeanToJson(this);
}