
import 'package:json_annotation/json_annotation.dart';

import 'ArticleBean.dart';

part 'ArticleResponse.g.dart';


@JsonSerializable()
class ArticleResponse {

  List<ArticleBean>? data;

  ArticleResponse({this.data});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => _$ArticleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}
