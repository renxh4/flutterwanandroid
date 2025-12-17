import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key, required this.url, this.title});

  final String url;
  final String? title;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  WebViewController? _controller;
  int _progress = 0;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // 在 Web 端直接打开新标签页
      _openInBrowser();
    } else {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (p) => setState(() => _progress = p),
            onWebResourceError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('加载失败: ${error.description}')),
              );
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.url));
    }
  }

  Future<void> _openInBrowser() async {
    final Uri uri = Uri.parse(widget.url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('无法在浏览器打开链接')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
        actions: [
          if (!kIsWeb)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _controller?.reload(),
            ),
          if (kIsWeb)
            IconButton(
              icon: const Icon(Icons.open_in_new),
              onPressed: _openInBrowser,
            ),
        ],
        bottom: !kIsWeb
            ? PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: _progress < 100
                    ? LinearProgressIndicator(value: _progress / 100)
                    : const SizedBox.shrink(),
              )
            : null,
      ),
      body: SafeArea(
        child: kIsWeb
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('已为你在新标签页打开网页'),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _openInBrowser,
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('再次打开'),
                    )
                  ],
                ),
              )
            : WebViewWidget(controller: _controller!),
      ),
    );
  }
}


