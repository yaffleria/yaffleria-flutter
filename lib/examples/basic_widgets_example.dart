import 'package:flutter/material.dart';

/// 기본 위젯 학습 예제
/// Text, Container, Row, Column, Image, Icon 등 기본 위젯들을 배웁니다.
class BasicWidgetsExample extends StatelessWidget {
  const BasicWidgetsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1. 기본 위젯'), elevation: 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text 위젯
            _buildSectionTitle('Text 위젯'),
            const Text('기본 텍스트입니다.'),
            const Text(
              '스타일이 적용된 텍스트',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Text(
              '이탤릭체와 밑줄이 있는 텍스트',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 24),

            // Container 위젯
            _buildSectionTitle('Container 위젯'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: const Text(
                'Container는 padding, margin, 색상, 테두리 등을 설정할 수 있습니다.',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 200,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.purple, Colors.pink]),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '그라디언트와 그림자',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Row 위젯
            _buildSectionTitle('Row 위젯 (가로 배치)'),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColorBox(Colors.red, '1'),
                  _buildColorBox(Colors.green, '2'),
                  _buildColorBox(Colors.blue, '3'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Column 위젯
            _buildSectionTitle('Column 위젯 (세로 배치)'),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildColorBox(Colors.orange, '1'),
                  const SizedBox(height: 8),
                  _buildColorBox(Colors.purple, '2'),
                  const SizedBox(height: 8),
                  _buildColorBox(Colors.teal, '3'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Icon 위젯
            _buildSectionTitle('Icon 위젯'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.red, size: 40),
                    const SizedBox(height: 4),
                    const Text('하트'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 40),
                    const SizedBox(height: 4),
                    const Text('별'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.blue, size: 40),
                    const SizedBox(height: 4),
                    const Text('좋아요'),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.home, color: Colors.green, size: 40),
                    const SizedBox(height: 4),
                    const Text('홈'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // 조합 예제
            _buildSectionTitle('위젯 조합 예제'),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.blue,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '새로운 알림',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '여러 위젯을 조합하여 복잡한 UI를 만들 수 있습니다.',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildColorBox(Color color, String label) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
