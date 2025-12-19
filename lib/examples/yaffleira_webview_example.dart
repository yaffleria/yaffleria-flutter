import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'dart:io';

/// Yaffleira WebView 예제
///
/// React WebView와 handshake 프로토콜을 통해 양방향 통신을 수행합니다.
/// http://localhost:5173 에서 실행 중인 React 앱과 연결됩니다.
class YaffleiraWebViewExample extends StatefulWidget {
  const YaffleiraWebViewExample({super.key});

  @override
  State<YaffleiraWebViewExample> createState() =>
      _YaffleiraWebViewExampleState();
}

class _YaffleiraWebViewExampleState extends State<YaffleiraWebViewExample> {
  late final WebViewController controller;
  bool isHandshakeComplete = false;
  bool isLoading = true;
  String? error;
  int messageCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF0F172A)) // React 앱 배경색과 동일
      ..addJavaScriptChannel(
        'FlutterBridge',
        onMessageReceived: (JavaScriptMessage message) {
          _handleWebViewMessage(message.message);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
              error = null;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
            // WebView 로드 완료 - WebView로부터 handshake를 기다림
            debugPrint(
              '[Flutter] 📱 Page loaded, waiting for WebView handshake...',
            );

            // FlutterBridge가 제대로 등록되었는지 확인
            controller.runJavaScript('''
              console.log('[Debug] Checking FlutterBridge availability...');
              console.log('[Debug] window.FlutterBridge:', typeof window.FlutterBridge);
              console.log('[Debug] window.FlutterBridge.postMessage:', typeof window.FlutterBridge?.postMessage);
              if (window.FlutterBridge && window.FlutterBridge.postMessage) {
                console.log('[Debug] ✅ FlutterBridge is available!');
              } else {
                console.error('[Debug] ❌ FlutterBridge is NOT available!');
              }
              
              // React 앱이 마운트되었는지 확인
              setTimeout(function() {
                var rootDiv = document.getElementById('root');
                console.log('[Debug] React root element:', rootDiv ? 'found' : 'not found');
                console.log('[Debug] React root innerHTML length:', rootDiv ? rootDiv.innerHTML.length : 0);
                console.log('[Debug] window.onFlutterMessage:', typeof window.onFlutterMessage);
                
                // bridge가 초기화되었는지 확인
                if (window.onFlutterMessage) {
                  console.log('[Debug] ✅ window.onFlutterMessage is set!');
                  
                  // 수동으로 handshake 테스트
                  console.log('[Debug] Testing manual handshake...');
                  try {
                    window.FlutterBridge.postMessage(JSON.stringify({
                      id: 'test_' + Date.now(),
                      type: 'handshake',
                      payload: { source: 'web', ready: true, manual: true },
                      timestamp: Date.now()
                    }));
                    console.log('[Debug] ✅ Manual handshake sent!');
                  } catch (e) {
                    console.error('[Debug] ❌ Failed to send manual handshake:', e);
                  }
                } else {
                  console.error('[Debug] ❌ window.onFlutterMessage is NOT set!');
                }
              }, 1000);
            ''');
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              this.error = error.description;
              isLoading = false;
            });
          },
        ),
      )
      // WebView 콘솔 로그를 Flutter 로그로 출력
      ..setOnConsoleMessage((JavaScriptConsoleMessage message) {
        debugPrint(
          '[WebView Console] ${message.level.name}: ${message.message}',
        );
      })
      // Android 에뮬레이터: 호스트 머신의 네트워크 IP 사용
      // 주의: 10.0.2.2는 localhost를 가리키지만, Vite 개발 서버가
      // 네트워크 인터페이스에 바인드되어 있으므로 실제 IP를 사용해야 함
      ..loadRequest(Uri.parse('http://192.168.45.78:5173'));
  }

  /// WebView로부터 받은 메시지 처리
  void _handleWebViewMessage(String messageString) {
    try {
      debugPrint('[Flutter] ✉️ Received from WebView: $messageString');

      setState(() {
        messageCount++;
      });

      final message = jsonDecode(messageString) as Map<String, dynamic>;
      final type = message['type'] as String;
      final id = message['id'] as String;
      final payload = message['payload'] as Map<String, dynamic>?;

      switch (type) {
        case 'handshake':
          _handleHandshake(payload);
          break;

        case 'action':
          _handleAction(id, payload);
          break;

        default:
          debugPrint('[Flutter] ⚠️ Unknown message type: $type');
      }
    } catch (e) {
      debugPrint('[Flutter] ❌ Error handling message: $e');
    }
  }

  /// Handshake 처리 - WebView로부터 handshake 수신 시 응답
  void _handleHandshake(Map<String, dynamic>? payload) {
    debugPrint('[Flutter] 🤝 WebView handshake received: $payload');

    // WebView가 준비되었으므로 deviceInfo와 함께 응답
    _sendToWebView({
      'id': 'handshake_response_${DateTime.now().millisecondsSinceEpoch}',
      'type': 'handshake',
      'payload': {'deviceInfo': _getDeviceInfo()},
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });

    debugPrint('[Flutter] 📤 Sent handshake response with deviceInfo');

    if (mounted) {
      setState(() {
        isHandshakeComplete = true;
      });

      // 성공 스낵바 표시
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Handshake 완료!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  /// 디바이스 정보 생성
  Map<String, dynamic> _getDeviceInfo() {
    return {
      'platform': Platform.isAndroid ? 'android' : 'ios',
      'osVersion': Platform.operatingSystemVersion,
      'appVersion': '1.0.0',
      'deviceModel': Platform.operatingSystem,
      'deviceId': 'device_${DateTime.now().millisecondsSinceEpoch}',
    };
  }

  /// Action 처리
  void _handleAction(String messageId, Map<String, dynamic>? payload) {
    if (payload == null) {
      _sendActionResponse(messageId, success: false, error: 'No payload');
      return;
    }

    final action = payload['action'] as String;
    final params = payload['params'] as Map<String, dynamic>? ?? {};

    debugPrint('[Flutter] 🎯 Handling action: $action with params: $params');

    try {
      switch (action) {
        case 'showToast':
          _handleShowToast(messageId, params);
          break;

        case 'closeWebView':
          _handleCloseWebView(messageId);
          break;

        case 'openUrl':
          _handleOpenUrl(messageId, params);
          break;

        case 'navigate':
          _handleNavigate(messageId, params);
          break;

        case 'share':
          _handleShare(messageId, params);
          break;

        case 'getDeviceInfo':
          _handleGetDeviceInfo(messageId);
          break;

        default:
          _sendActionResponse(
            messageId,
            success: false,
            error: 'Unknown action: $action',
          );
      }
    } catch (e) {
      _sendActionResponse(messageId, success: false, error: e.toString());
    }
  }

  /// Toast 표시 (SnackBar)
  void _handleShowToast(String messageId, Map<String, dynamic> params) {
    final message = params['message'] as String? ?? 'Hello!';

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
      );
    }

    _sendActionResponse(messageId, success: true);
  }

  /// WebView 닫기
  void _handleCloseWebView(String messageId) {
    _sendActionResponse(messageId, success: true);

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  /// URL 열기
  void _handleOpenUrl(String messageId, Map<String, dynamic> params) {
    final url = params['url'] as String?;

    if (url == null) {
      _sendActionResponse(messageId, success: false, error: 'No URL provided');
      return;
    }

    debugPrint('[Flutter] 🌐 Opening URL: $url');

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('URL 열기: $url')));
    }

    _sendActionResponse(messageId, success: true, data: {'url': url});
  }

  /// 페이지 이동
  void _handleNavigate(String messageId, Map<String, dynamic> params) {
    final route = params['route'] as String?;

    if (route == null) {
      _sendActionResponse(
        messageId,
        success: false,
        error: 'No route provided',
      );
      return;
    }

    debugPrint('[Flutter] 🧭 Navigating to: $route');

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('페이지 이동: $route')));
    }

    _sendActionResponse(messageId, success: true, data: {'route': route});
  }

  /// 공유하기
  void _handleShare(String messageId, Map<String, dynamic> params) {
    final text = params['text'] as String? ?? '';
    final url = params['url'] as String?;

    final shareText = url != null ? '$text\n$url' : text;

    debugPrint('[Flutter] 📤 Sharing: $shareText');

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('공유: $shareText')));
    }

    _sendActionResponse(messageId, success: true);
  }

  /// 디바이스 정보 제공
  void _handleGetDeviceInfo(String messageId) {
    _sendActionResponse(messageId, success: true, data: _getDeviceInfo());
  }

  /// WebView로 메시지 전송
  void _sendToWebView(Map<String, dynamic> message) {
    final messageString = jsonEncode(message);
    final jsCode =
        '''
      (function() {
        try {
          if (window.onFlutterMessage) {
            window.onFlutterMessage(${jsonEncode(messageString)});
          } else {
            console.warn('window.onFlutterMessage not available');
          }
        } catch (e) {
          console.error('Error receiving Flutter message:', e);
        }
      })();
    ''';

    controller.runJavaScript(jsCode);
    debugPrint(
      '[Flutter] 📤 Sent to WebView: ${message['type']} (id: ${message['id']})',
    );
  }

  /// Action 응답 전송
  void _sendActionResponse(
    String messageId, {
    required bool success,
    dynamic data,
    String? error,
  }) {
    _sendToWebView({
      'id': messageId,
      'type': 'response',
      'payload': {'success': success, 'data': data, 'error': error},
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  /// WebView 새로고침
  void _reloadWebView() {
    controller.reload();
    setState(() {
      error = null;
      isHandshakeComplete = false;
      messageCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yaffleira WebView'),
        centerTitle: true,
        actions: [
          // Message Count Badge
          if (messageCount > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$messageCount',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

          // Handshake Status Indicator
          if (isHandshakeComplete)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.check_circle, color: Colors.green),
            ),

          // Loading Indicator
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),

          // Reload Button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _reloadWebView,
            tooltip: '새로고침',
          ),
        ],
      ),
      body: error != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '오류 발생',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _reloadWebView,
                      icon: const Icon(Icons.refresh),
                      label: const Text('다시 시도'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('도움말'),
                            content: const Text(
                              '1. React 개발 서버가 실행 중인지 확인하세요.\n'
                              '   (http://localhost:5173)\n\n'
                              '2. 터미널에서 다음 명령을 실행하세요:\n'
                              '   pnpm dev\n\n'
                              '3. 브라우저에서 localhost:5173이 열리는지 확인하세요.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('확인'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('도움말'),
                    ),
                  ],
                ),
              ),
            )
          : WebViewWidget(controller: controller),
      floatingActionButton: isHandshakeComplete
          ? FloatingActionButton.extended(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('📊 통신 상태'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow('Handshake', '✅ 완료'),
                        const SizedBox(height: 8),
                        _buildInfoRow('메시지 송수신', '$messageCount개'),
                        const SizedBox(height: 8),
                        _buildInfoRow('플랫폼', Platform.operatingSystem),
                        const SizedBox(height: 8),
                        _buildInfoRow('URL', 'localhost:5173'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('확인'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.info_outline),
              label: const Text('상태'),
            )
          : null,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }
}
