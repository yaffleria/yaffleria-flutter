import 'package:flutter/material.dart';

/// Navigation 학습 예제
/// 화면 전환과 데이터 전달을 배웁니다.
class NavigationExample extends StatelessWidget {
  const NavigationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('4. 화면 전환'), elevation: 2),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '화면 전환 방법',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // 기본 화면 전환
          _buildNavigationCard(
            context,
            title: '기본 화면 전환',
            description: 'Navigator.push를 사용한 기본 화면 이동',
            icon: Icons.arrow_forward,
            color: Colors.blue,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SecondScreen(title: '두 번째 화면'),
                ),
              );
            },
          ),

          // 데이터 전달
          _buildNavigationCard(
            context,
            title: '데이터 전달하기',
            description: '다음 화면으로 데이터를 전달합니다',
            icon: Icons.send,
            color: Colors.green,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DetailScreen(
                    title: '상세 정보',
                    message: '이것은 전달된 메시지입니다!',
                    count: 42,
                  ),
                ),
              );
            },
          ),

          // 결과 받기
          _buildNavigationCard(
            context,
            title: '결과 받아오기',
            description: '이전 화면으로부터 결과를 받아옵니다',
            icon: Icons.reply,
            color: Colors.orange,
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectionScreen(),
                ),
              );

              if (context.mounted && result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('선택한 결과: $result'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
          ),

          // 애니메이션 전환
          _buildNavigationCard(
            context,
            title: '애니메이션 전환',
            description: '커스텀 애니메이션으로 화면 전환',
            icon: Icons.animation,
            color: Colors.purple,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const AnimatedScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);

                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}

// 두 번째 화면
class SecondScreen extends StatelessWidget {
  final String title;
  const SecondScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 24),
            const Text(
              '두 번째 화면입니다!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('돌아가기'),
            ),
          ],
        ),
      ),
    );
  }
}

// 상세 정보 화면
class DetailScreen extends StatelessWidget {
  final String title;
  final String message;
  final int count;

  const DetailScreen({
    super.key,
    required this.title,
    required this.message,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(Icons.info, size: 64, color: Colors.blue),
                    const SizedBox(height: 16),
                    const Text(
                      '전달받은 데이터:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('메시지: $message', style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text('숫자: $count', style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 선택 화면
class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('항목 선택')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            '하나를 선택하세요:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...[
            {'name': '사과', 'icon': Icons.apple, 'color': Colors.red},
            {
              'name': '바나나',
              'icon': Icons.emoji_food_beverage,
              'color': Colors.yellow,
            },
            {'name': '포도', 'icon': Icons.circle, 'color': Colors.purple},
          ].map((item) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                ),
                title: Text(item['name'] as String),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.pop(context, item['name']),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// 애니메이션 화면
class AnimatedScreen extends StatelessWidget {
  const AnimatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('애니메이션 전환')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade300, Colors.blue.shade300],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 100, color: Colors.white),
              const SizedBox(height: 24),
              const Text(
                '멋진 애니메이션!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('돌아가기'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
