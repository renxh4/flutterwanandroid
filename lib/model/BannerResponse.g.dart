// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BannerResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BannerBean.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BannerResponseToJson(BannerResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
