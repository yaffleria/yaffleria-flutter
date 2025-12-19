import 'package:flutter/material.dart';
import 'examples/basic_widgets_example.dart';
import 'examples/stateful_widget_example.dart';
import 'examples/list_view_example.dart';
import 'examples/navigation_example.dart';
import 'examples/form_example.dart';
import 'examples/webview_example.dart';
import 'examples/ui_components_example.dart';
import 'examples/toss_style_example.dart';
import 'examples/yaffleira_webview_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 학습 앱',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        useMaterial3: false,
        splashFactory: NoSplash.splashFactory, // Shader 문제 우회
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 학습 앱'),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Icon(Icons.school, size: 80, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text(
              '🎉 Flutter 학습을 시작하세요!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              '아래 예제들을 순서대로 학습하면\nFlutter의 기본을 마스터할 수 있습니다.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            _buildLessonCard(
              context,
              number: '1',
              title: '기본 위젯',
              description: 'Text, Container, Row, Column 등 기본 위젯',
              icon: Icons.widgets,
              color: Colors.blue,
              difficulty: '⭐ 초급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BasicWidgetsExample(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLessonCard(
              context,
              number: '2',
              title: '상태 관리',
              description: 'StatefulWidget과 setState로 상태 관리',
              icon: Icons.toggle_on,
              color: Colors.green,
              difficulty: '⭐⭐ 초중급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const StatefulWidgetExample(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLessonCard(
              context,
              number: '3',
              title: '리스트 뷰',
              description: 'ListView로 스크롤 가능한 목록 만들기',
              icon: Icons.list,
              color: Colors.orange,
              difficulty: '⭐⭐ 초중급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ListViewExample(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLessonCard(
              context,
              number: '4',
              title: '화면 전환',
              description: 'Navigator로 여러 화면 간 이동하기',
              icon: Icons.navigation,
              color: Colors.purple,
              difficulty: '⭐⭐⭐ 중급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavigationExample(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLessonCard(
              context,
              number: '5',
              title: '폼과 입력',
              description: 'Form과 TextField로 사용자 입력 처리',
              icon: Icons.edit,
              color: Colors.red,
              difficulty: '⭐⭐⭐ 중급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FormExample()),
              ),
            ),
            const SizedBox(height: 16),
            _buildLessonCard(
              context,
              number: '6',
              title: 'WebView',
              description: '웹 페이지를 앱 안에서 보여주기',
              icon: Icons.web,
              color: Colors.deepPurple,
              difficulty: '⭐⭐⭐ 중급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WebViewExample()),
              ),
            ),
            const SizedBox(height: 16),
            _buildLessonCard(
              context,
              number: '7',
              title: 'UI 컴포넌트',
              description: '다이얼로그, 바텀시트, 스냅바 등',
              icon: Icons.dashboard_customize,
              color: Colors.teal,
              difficulty: '⭐⭐⭐ 중급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UIComponentsExample(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLessonCard(
              context,
              number: '8',
              title: '토스 스타일 UI',
              description: '커스텀 디자인 (토스 느낌)',
              icon: Icons.credit_card,
              color: Color(0xFF0064FF),
              difficulty: '⭐⭐⭐⭐ 고급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TossStyleExample(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildLessonCard(
              context,
              number: '9',
              title: '🚀 Yaffleira WebView',
              description: 'React ↔ Flutter 양방향 통신 (Handshake)',
              icon: Icons.sync_alt,
              color: const Color(0xFF6366f1),
              difficulty: '⭐⭐⭐⭐ 고급',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const YaffleiraWebViewExample(),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildLessonCard(
    BuildContext context, {
    required String number,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String difficulty,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(icon, size: 20, color: color),
                        const SizedBox(width: 8),
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      difficulty,
                      style: TextStyle(
                        fontSize: 12,
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
