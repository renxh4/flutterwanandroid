import 'package:flutter/services.dart' show rootBundle;
import '../model/moment_models.dart';

class MomentsRepository {
  static const String defaultAssetPath = 'assets/303379832_export.json';

  Future<List<Moment>> load({String assetPath = defaultAssetPath}) async {
    final String jsonStr = await rootBundle.loadString(assetPath);
    final MomentsData data = parseMomentsFromString(jsonStr);
    // 可按时间排序（若 timestamp 可解析）
    final List<Moment> list = List<Moment>.from(data.moments);
    list.sort((a, b) => (b.timestamp ?? '').compareTo(a.timestamp ?? ''));
    return list;
  }
}


