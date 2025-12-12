import 'package:json_annotation/json_annotation.dart';

part 'HttpBinGetResponse.g.dart';

@JsonSerializable()
class HttpBinGetResponse {
  final Map<String, dynamic> args;
  final Map<String, dynamic> headers;
  final String origin;
  final String url;

  HttpBinGetResponse({
    required this.args,
    required this.headers,
    required this.origin,
    required this.url,
  });

  factory HttpBinGetResponse.fromJson(Map<String, dynamic> json) => _$HttpBinGetResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HttpBinGetResponseToJson(this);
}


