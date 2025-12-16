import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';

import '../model/moment_models.dart';
import 'webview_page.dart';

class MomentsPage extends StatefulWidget {
  const MomentsPage({super.key});

  @override
  State<MomentsPage> createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> with SingleTickerProviderStateMixin {
  late Future<void> _future;

  // 数据分栏
  List<Moment> _moments = <Moment>[];
  List<Map<String, dynamic>> _boardMessages = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    _future = _loadAll();
  }

  Future<void> _loadAll() async {
    final String jsonStr = await rootBundle.loadString('assets/303379832_export.json');
    final Map<String, dynamic> map = json.decode(jsonStr) as Map<String, dynamic>;
    final List<dynamic> momentsRaw = (map['Moments'] as List<dynamic>?) ?? <dynamic>[];
    _moments = momentsRaw.map((e) => Moment.fromJson(e as Map<String, dynamic>)).toList();
    // 仅保留留言
    _boardMessages = ((map['BoardMessages'] as List<dynamic>?) ?? <dynamic>[]).cast<Map<String, dynamic>>();

    // 简单时间倒序（若存在 ISO8601）
    _moments.sort((a, b) => (b.timestamp ?? '').compareTo(a.timestamp ?? ''));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('QZone'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: '说说'),
              Tab(text: '留言'),
              Tab(text: '总结'),
            ],
          ),
        ),
        body: FutureBuilder<void>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('加载失败: ${snapshot.error}'));
            }
            return TabBarView(
              children: [
                _buildMoments(),
                _buildBoard(),
                _buildSummary(),
              ],
            );
          },
        ),
      ),
    );
  }

  // Summary（按年统计说说数量）
  Widget _buildSummary() {
    if (_moments.isEmpty) return const Center(child: Text('暂无数据'));
    final Map<String, List<Moment>> yearToList = _groupMomentsByYear();
    final List<String> years = yearToList.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // 年份倒序
    return ListView.builder(
      itemCount: years.length,
      itemBuilder: (context, index) {
        final String year = years[index];
        final List<Moment> list = yearToList[year] ?? <Moment>[];
        return ExpansionTile(
          leading: const Icon(Icons.timeline),
          title: Text('$year 年'),
          trailing: Text('${list.length} 条说说'),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, i) => _MomentCard(moment: list[i]),
            ),
          ],
        );
      },
    );
  }

  Map<String, int> _countMomentsByYear() {
    final Map<String, int> acc = <String, int>{};
    for (final m in _moments) {
      final String yearStr = _extractYear(m);
      acc.update(yearStr, (v) => v + 1, ifAbsent: () => 1);
    }
    return acc;
  }

  Map<String, List<Moment>> _groupMomentsByYear() {
    final Map<String, List<Moment>> map = <String, List<Moment>>{};
    for (final m in _moments) {
      final String year = _extractYear(m);
      map.putIfAbsent(year, () => <Moment>[]).add(m);
    }
    return map;
  }

  String _extractYear(Moment m) {
    final String? ts = m.timestamp;
    final String? tt = m.timeText;
    String? yearStr;
    if (ts != null && ts.isNotEmpty) {
      try {
        final DateTime dt = DateTime.parse(ts);
        yearStr = dt.year.toString();
      } catch (_) {
        // ignore parse error, fallback to timeText
      }
    }
    if (yearStr == null && tt != null && tt.isNotEmpty) {
      final RegExp zhYear = RegExp(r'(\d{4})年');
      final RegExpMatch? m1 = zhYear.firstMatch(tt);
      if (m1 != null) {
        yearStr = m1.group(1);
      } else {
        final RegExp anyYear = RegExp(r'(\d{4})');
        final RegExpMatch? m2 = anyYear.firstMatch(tt);
        if (m2 != null) {
          yearStr = m2.group(1);
        }
      }
    }
    return yearStr ?? '未知';
  }

  // Moment
  Widget _buildMoments() {
    if (_moments.isEmpty) return const Center(child: Text('暂无动态'));
    return ListView.builder(
      itemCount: _moments.length,
      itemBuilder: (context, index) => _MomentCard(moment: _moments[index]),
    );
  }

  // BoardMessage
  Widget _buildBoard() {
    if (_boardMessages.isEmpty) return const Center(child: Text('暂无留言'));
    return ListView.builder(
      itemCount: _boardMessages.length,
      itemBuilder: (context, index) {
        final m = _boardMessages[index];
        final sender = (m['senderQQ'] ?? '').toString();
        final content = (m['content'] ?? '').toString();
        final timeText = (m['timeText'] ?? m['timestamp'] ?? '').toString();
        return ListTile(
          leading: const Icon(Icons.message_outlined),
          title: Text(content),
          subtitle: Text('$sender · $timeText'),
        );
      },
    );
  }

}

class _MomentCard extends StatelessWidget {
  const _MomentCard({required this.moment});
  final Moment moment;

  @override
  Widget build(BuildContext context) {
    final Color fg = moment.isDeleted ? Colors.grey : Colors.black87;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  child: Text((moment.senderQQ ?? '?').characters.take(2).toString()),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(moment.senderQQ ?? 'Unknown', style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 2),
                      Text(moment.timeText ?? '', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
            if ((moment.content ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              _ContentText(text: moment.content!),
            ],
            if (moment.hasImages) ...[
              const SizedBox(height: 8),
              _ImageGrid(urls: moment.imageURLs),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.favorite_border, size: 18, color: Colors.red[400]),
                const SizedBox(width: 4),
                Text('${moment.likes ?? 0}', style: TextStyle(color: fg)),
                const Spacer(),
                Icon(Icons.visibility_outlined, size: 18, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text('${moment.views ?? 0}', style: TextStyle(color: fg)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageGrid extends StatelessWidget {
  const _ImageGrid({required this.urls});
  final List<String> urls;

  @override
  Widget build(BuildContext context) {
    final int crossAxisCount = urls.length == 1 ? 1 : (urls.length == 2 || urls.length == 4 ? 2 : 3);
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1,
      ),
      itemCount: urls.length,
      itemBuilder: (context, index) {
        final String url = urls[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: Colors.grey[300],
              alignment: Alignment.center,
              child: const Icon(Icons.broken_image_outlined),
            ),
          ),
        );
      },
    );
  }
}

class _ContentText extends StatelessWidget {
  const _ContentText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    // 简单识别 http/https 链接
    final RegExp reg = RegExp(r'(https?://[^\s]+)');
    final Iterable<RegExpMatch> matches = reg.allMatches(text);
    if (matches.isEmpty) {
      return Text(text);
    }
    final List<InlineSpan> spans = <InlineSpan>[];
    int last = 0;
    for (final m in matches) {
      if (m.start > last) {
        spans.add(TextSpan(text: text.substring(last, m.start)));
      }
      final String url = text.substring(m.start, m.end);
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: GestureDetector(
          onTap: () => Get.to(() => WebViewPage(url: url, title: url)),
          child: Text(
            url,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ));
      last = m.end;
    }
    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last)));
    }
    return RichText(text: TextSpan(style: DefaultTextStyle.of(context).style, children: spans));
  }
}


