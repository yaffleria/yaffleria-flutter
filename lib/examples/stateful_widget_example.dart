import 'package:flutter/material.dart';

/// StatefulWidget 학습 예제
/// setState를 사용한 상태 관리와 사용자 상호작용을 배웁니다.
class StatefulWidgetExample extends StatefulWidget {
  const StatefulWidgetExample({super.key});

  @override
  State<StatefulWidgetExample> createState() => _StatefulWidgetExampleState();
}

class _StatefulWidgetExampleState extends State<StatefulWidgetExample> {
  // 상태 변수들
  int _counter = 0;
  bool _isLiked = false;
  bool _isSubscribed = false;
  double _sliderValue = 50;
  Color _selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('2. 상태 관리 (Stateful Widget)'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 카운터 예제
            _buildSectionTitle('카운터 예제'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text('버튼을 클릭한 횟수:', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 12),
                    Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _counter++;
                            });
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('증가'),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              if (_counter > 0) _counter--;
                            });
                          },
                          icon: const Icon(Icons.remove),
                          label: const Text('감소'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _counter = 0;
                            });
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('리셋'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 좋아요/구독 예제
            _buildSectionTitle('버튼 토글 예제'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 좋아요 버튼
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isLiked = !_isLiked;
                                });
                              },
                              icon: Icon(
                                _isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _isLiked ? Colors.red : Colors.grey,
                                size: 48,
                              ),
                            ),
                            Text(
                              _isLiked ? '좋아요!' : '좋아요 누르기',
                              style: TextStyle(
                                color: _isLiked ? Colors.red : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        // 구독 버튼
                        Column(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _isSubscribed = !_isSubscribed;
                                });
                              },
                              icon: Icon(
                                _isSubscribed
                                    ? Icons.notifications_active
                                    : Icons.notifications_none,
                              ),
                              label: Text(_isSubscribed ? '구독 중' : '구독하기'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _isSubscribed ? Colors.grey : Colors.red,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _isSubscribed ? '구독 감사합니다!' : '채널을 구독하세요',
                              style: TextStyle(
                                color: _isSubscribed ? Colors.red : Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 슬라이더 예제
            _buildSectionTitle('슬라이더 예제'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      '값: ${_sliderValue.toInt()}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Slider(
                      value: _sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _sliderValue.toInt().toString(),
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                    // 슬라이더 값에 따른 시각적 표현
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _sliderValue / 100,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [Colors.green, Colors.blue],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // 색상 선택 예제
            _buildSectionTitle('색상 선택 예제'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          '선택된 색상',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('색상을 선택하세요:'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildColorButton(Colors.red, '빨강'),
                        _buildColorButton(Colors.blue, '파랑'),
                        _buildColorButton(Colors.green, '초록'),
                        _buildColorButton(Colors.orange, '주황'),
                        _buildColorButton(Colors.purple, '보라'),
                        _buildColorButton(Colors.pink, '분홍'),
                      ],
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

  Widget _buildColorButton(Color color, String label) {
    final isSelected = _selectedColor == color;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
        });
      },
      child: Container(
        width: 80,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? Border.all(color: Colors.black, width: 3) : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
