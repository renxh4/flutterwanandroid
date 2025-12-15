// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BannerBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerBean _$BannerBeanFromJson(Map<String, dynamic> json) => BannerBean(
      id: (json['id'] as num?)?.toInt(),
      imagePath: json['imagePath'] as String?,
      title: json['title'] as String?,
      url: json['url'] as String?,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$BannerBeanToJson(BannerBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imagePath': instance.imagePath,
      'title': instance.title,
      'url': instance.url,
      'desc': instance.desc,
    };
