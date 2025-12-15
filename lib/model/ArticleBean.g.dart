// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleBean _$ArticleBeanFromJson(Map<String, dynamic> json) => ArticleBean(
      total: (json['total'] as num?)?.toInt(),
      datas: (json['datas'] as List<dynamic>?)
          ?.map((e) => ArticleDetialBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleBeanToJson(ArticleBean instance) =>
    <String, dynamic>{
      'total': instance.total,
      'datas': instance.datas,
    };
