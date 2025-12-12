// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ResponseBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseBean<T> _$ResponseBeanFromJson<T>(Map<String, dynamic> json) =>
    ResponseBean<T>(
      code: (json['code'] as num?)?.toInt(),
      msg: json['msg'] as String?,
    );

Map<String, dynamic> _$ResponseBeanToJson<T>(ResponseBean<T> instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
    };
