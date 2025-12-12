import 'package:json_annotation/json_annotation.dart';

part 'test_request_bean.g.dart';

@JsonSerializable()
class TestRequestBean {
  String? name;
  int? age;

  TestRequestBean({this.name, this.age});

  factory TestRequestBean.fromJson(Map<String, dynamic> json) =>
      _$TestRequestBeanFromJson(json);
  Map<String, dynamic> toJson() => _$TestRequestBeanToJson(this);
}


