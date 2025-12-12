
import 'package:json_annotation/json_annotation.dart';

part 'ResponseBean.g.dart';

@JsonSerializable()
class ResponseBean<T> {
  int? code;
  String? msg;
  ResponseBean({this.code, this.msg});

  factory ResponseBean.fromJson(Map<String, dynamic> json) =>
      _$ResponseBeanFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseBeanToJson(this);
}
