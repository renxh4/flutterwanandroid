import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/moment_models.dart';
import '../services/moments_repository.dart';
import 'webview_page.dart';

class MomentsPage extends StatefulWidget {
  const MomentsPage({super.key});

  @override
  State<MomentsPage> createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  final MomentsRepository _repo = MomentsRepository();
  late Future<List<Moment>> _future;

  @override
  void initState() {
    super.initState();
    _future = _repo.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Moments')),
      body: FutureBuilder<List<Moment>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('加载失败: ${snapshot.error}'));
          }
          final List<Moment> moments = snapshot.data ?? <Moment>[];
          if (moments.isEmpty) {
            return const Center(child: Text('暂无动态'));
          }
          return ListView.builder(
            itemCount: moments.length,
            itemBuilder: (context, index) {
              final Moment m = moments[index];
              return _MomentCard(moment: m);
            },
          );
        },
      ),
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


