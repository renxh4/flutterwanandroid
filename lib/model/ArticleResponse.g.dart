// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleResponse _$ArticleResponseFromJson(Map<String, dynamic> json) =>
    ArticleResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ArticleBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleResponseToJson(ArticleResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
