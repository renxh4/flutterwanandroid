// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_request_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestRequestBean _$TestRequestBeanFromJson(Map<String, dynamic> json) =>
    TestRequestBean(
      name: json['name'] as String?,
      age: (json['age'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TestRequestBeanToJson(TestRequestBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
    };
