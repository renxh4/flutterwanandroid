import 'dart:convert';

class MomentsData {
  final List<Moment> moments;

  MomentsData({required this.moments});

  factory MomentsData.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['Moments'] as List<dynamic>? ?? <dynamic>[];
    return MomentsData(
      moments: list.map((e) => Moment.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class Moment {
  final String id;
  final String? userQQ;
  final String? senderQQ;
  final String? content;
  final String? timestamp; // ISO8601 字符串
  final String? timeText;  // 显示用
  final List<String> imageURLs;
  final int? likes;
  final int? views;
  final bool isDeleted;
  final bool? isReconstructed;

  bool get hasImages => imageURLs.isNotEmpty;

  Moment({
    required this.id,
    this.userQQ,
    this.senderQQ,
    this.content,
    this.timestamp,
    this.timeText,
    this.imageURLs = const <String>[],
    this.likes,
    this.views,
    required this.isDeleted,
    this.isReconstructed,
  });

  factory Moment.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? imgs = json['imageURLs'] as List<dynamic>?;
    return Moment(
      id: (json['id'] ?? '') as String,
      userQQ: json['userQQ'] as String?,
      senderQQ: json['senderQQ'] as String?,
      content: json['content'] as String?,
      timestamp: json['timestamp'] as String?,
      timeText: json['timeText'] as String?,
      imageURLs: imgs == null ? <String>[] : imgs.map((e) => e as String? ?? '').where((e) => e.isNotEmpty).toList(),
      likes: json['likes'] as int?,
      views: json['views'] as int?,
      isDeleted: (json['isDeleted'] ?? false) as bool,
      isReconstructed: json['isReconstructed'] as bool?,
    );
  }
}

/// 工具：从字符串直接解析
MomentsData parseMomentsFromString(String source) {
  final Map<String, dynamic> map = json.decode(source) as Map<String, dynamic>;
  return MomentsData.fromJson(map);
}


