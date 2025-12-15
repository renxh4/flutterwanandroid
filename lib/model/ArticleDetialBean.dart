

import 'package:json_annotation/json_annotation.dart';

part 'ArticleDetialBean.g.dart';


@JsonSerializable()
class ArticleDetialBean {
  String? apkLink;
  String? author;


  ArticleDetialBean({this.apkLink, this.author});

  factory ArticleDetialBean.fromJson(Map<String, dynamic> json) => _$ArticleDetialBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleDetialBeanToJson(this);
}
