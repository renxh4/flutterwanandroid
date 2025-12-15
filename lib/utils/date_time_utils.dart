import 'package:intl/intl.dart';

/// 时间工具：时间戳与格式化
class DateTimeUtils {
  /// 将时间戳转换为 [DateTime]
  /// - 自动判断秒/毫秒：小于 10^12 视为秒，否则视为毫秒
  /// - [isUtc]: 是否按 UTC 解释
  static DateTime fromTimestamp(int timestamp, {bool isUtc = false}) {
    final bool isMilliseconds = timestamp.abs() >= 1000000000000; // 10^12
    final int millis = isMilliseconds ? timestamp : timestamp * 1000;
    return isUtc
        ? DateTime.fromMillisecondsSinceEpoch(millis, isUtc: true)
        : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  /// 将时间戳格式化为字符串
  /// - [pattern] 例如：'yyyy-MM-dd HH:mm:ss'
  /// - [locale] 例如：'zh_CN'、'en_US'
  /// - [isUtc] 是否按 UTC 格式化
  static String formatTimestamp(
    int timestamp, {
    String pattern = 'yyyy-MM-dd HH:mm:ss',
    String? locale,
    bool isUtc = false,
  }) {
    final DateTime dateTime = fromTimestamp(timestamp, isUtc: isUtc);
    final DateFormat formatter = DateFormat(pattern, locale);
    return formatter.format(dateTime);
  }

  /// 返回相对时间（简易版），如：刚刚/分钟前/小时前/天前
  static String formatRelative(int timestamp, {DateTime? now}) {
    final DateTime current = now ?? DateTime.now();
    final DateTime time = fromTimestamp(timestamp);
    final Duration diff = current.difference(time);

    if (diff.inSeconds < 60) return '刚刚';
    if (diff.inMinutes < 60) return '${diff.inMinutes}分钟前';
    if (diff.inHours < 24) return '${diff.inHours}小时前';
    if (diff.inDays < 30) return '${diff.inDays}天前';

    // 超过 30 天，返回日期
    return DateFormat('yyyy-MM-dd').format(time);
  }
}


