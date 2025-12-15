
import 'package:flutterwanandroid/model/ArticleDetialBean.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ArticleBean.g.dart';


@JsonSerializable()
class ArticleBean {
  int? total;
  List<ArticleDetialBean>? datas;



  ArticleBean({this.total, this.datas});

  factory ArticleBean.fromJson(Map<String, dynamic> json) => _$ArticleBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ArticleBeanToJson(this);
}
