import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// WebView 사용 예제
///
/// 이 예제는 다음을 보여줍니다:
/// - WebView로 웹 페이지 표시
/// - URL 입력 및 탐색
/// - 뒤로/앞으로 이동
/// - 새로고침
class WebViewExample extends StatefulWidget {
  const WebViewExample({super.key});

  @override
  State<WebViewExample> createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  late final WebViewController controller;
  final TextEditingController urlController = TextEditingController();
  String currentUrl = 'https://www.google.com';
  bool isLoading = true;
  bool canGoBack = false;
  bool canGoForward = false;

  @override
  void initState() {
    super.initState();

    // WebView 컨트롤러 초기화
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              currentUrl = url;
              urlController.text = url;
            });
          },
          onPageFinished: (String url) async {
            setState(() {
              isLoading = false;
              currentUrl = url;
            });
            // 뒤로/앞으로 버튼 상태 업데이트
            final back = await controller.canGoBack();
            final forward = await controller.canGoForward();
            setState(() {
              canGoBack = back;
              canGoForward = forward;
            });
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(currentUrl));

    urlController.text = currentUrl;
  }

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  void _loadUrl(String url) {
    // URL에 프로토콜이 없으면 https:// 추가
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    controller.loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebView 예제'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // URL 입력 바
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // 뒤로 가기 버튼
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: canGoBack
                      ? () async {
                          await controller.goBack();
                        }
                      : null,
                  color: Colors.deepPurple,
                ),
                // 앞으로 가기 버튼
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: canGoForward
                      ? () async {
                          await controller.goForward();
                        }
                      : null,
                  color: Colors.deepPurple,
                ),
                // 새로고침 버튼
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    controller.reload();
                  },
                  color: Colors.deepPurple,
                ),
                // URL 입력 필드
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: urlController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'URL 입력',
                        isDense: true,
                      ),
                      onSubmitted: _loadUrl,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // 이동 버튼
                ElevatedButton(
                  onPressed: () {
                    _loadUrl(urlController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('이동'),
                ),
              ],
            ),
          ),

          // 로딩 인디케이터
          if (isLoading)
            const LinearProgressIndicator(color: Colors.deepPurple),

          // WebView
          Expanded(child: WebViewWidget(controller: controller)),

          // 하단 정보 바
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.grey[100],
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isLoading ? '로딩 중...' : '페이지 로드 완료',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // 빠른 링크 FAB
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showQuickLinks(context);
        },
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.link),
        label: const Text('빠른 링크'),
      ),
    );
  }

  void _showQuickLinks(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '빠른 링크',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildQuickLink(
                context,
                'Google',
                'https://www.google.com',
                Icons.search,
                Colors.blue,
              ),
              _buildQuickLink(
                context,
                'Flutter 공식 사이트',
                'https://flutter.dev',
                Icons.flutter_dash,
                Colors.lightBlue,
              ),
              _buildQuickLink(
                context,
                'GitHub',
                'https://github.com',
                Icons.code,
                Colors.black87,
              ),
              _buildQuickLink(
                context,
                'Stack Overflow',
                'https://stackoverflow.com',
                Icons.question_answer,
                Colors.orange,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickLink(
    BuildContext context,
    String title,
    String url,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(url, style: const TextStyle(fontSize: 12)),
      onTap: () {
        Navigator.pop(context);
        _loadUrl(url);
      },
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
