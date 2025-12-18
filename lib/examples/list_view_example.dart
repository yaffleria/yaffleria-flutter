import 'package:flutter/material.dart';

/// ListView 학습 예제
/// ListView, ListTile, GridView 등을 사용한 목록 표시를 배웁니다.
class ListViewExample extends StatelessWidget {
  const ListViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('3. 리스트 뷰'),
          elevation: 2,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'ListView'),
              Tab(icon: Icon(Icons.grid_on), text: 'GridView'),
              Tab(icon: Icon(Icons.build), text: 'Builder'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildListViewExample(),
            _buildGridViewExample(),
            _buildBuilderExample(),
          ],
        ),
      ),
    );
  }

  // 기본 ListView 예제
  Widget _buildListViewExample() {
    final items = [
      {'title': '사과', 'icon': Icons.apple, 'color': Colors.red},
      {
        'title': '바나나',
        'icon': Icons.emoji_food_beverage,
        'color': Colors.yellow,
      },
      {'title': '포도', 'icon': Icons.circle, 'color': Colors.purple},
      {'title': '오렌지', 'icon': Icons.circle, 'color': Colors.orange},
      {'title': '딸기', 'icon': Icons.favorite, 'color': Colors.pink},
      {'title': '수박', 'icon': Icons.circle, 'color': Colors.green},
      {'title': '복숭아', 'icon': Icons.circle, 'color': Colors.orange[300]!},
      {'title': '키위', 'icon': Icons.circle, 'color': Colors.brown},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            '기본 ListView 예제',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        ...items.map(
          (item) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: (item['color'] as Color).withOpacity(0.2),
                child: Icon(
                  item['icon'] as IconData,
                  color: item['color'] as Color,
                ),
              ),
              title: Text(item['title'] as String),
              subtitle: Text('${item['title']}에 대한 설명'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }

  // GridView 예제
  Widget _buildGridViewExample() {
    final colors = [
      {'name': '빨강', 'color': Colors.red},
      {'name': '파랑', 'color': Colors.blue},
      {'name': '초록', 'color': Colors.green},
      {'name': '노랑', 'color': Colors.yellow},
      {'name': '보라', 'color': Colors.purple},
      {'name': '주황', 'color': Colors.orange},
      {'name': '분홍', 'color': Colors.pink},
      {'name': '청록', 'color': Colors.teal},
      {'name': '남색', 'color': Colors.indigo},
      {'name': '청회색', 'color': Colors.blueGrey},
      {'name': '갈색', 'color': Colors.brown},
      {'name': '회색', 'color': Colors.grey},
    ];

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'GridView 예제 - 색상 팔레트',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            padding: const EdgeInsets.all(16),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            children: colors.map((item) {
              return Container(
                decoration: BoxDecoration(
                  color: item['color'] as Color,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    item['name'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ListView.builder 예제
  Widget _buildBuilderExample() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'ListView.builder 예제',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '많은 항목을 효율적으로 표시할 때 사용합니다.\n아래로 스크롤하여 100개의 항목을 확인하세요!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 100,
            itemBuilder: (context, index) {
              final icons = [
                Icons.star,
                Icons.favorite,
                Icons.thumb_up,
                Icons.emoji_emotions,
                Icons.celebration,
              ];
              final colors = [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.orange,
                Colors.purple,
              ];

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colors[index % 5].withOpacity(0.2),
                    child: Icon(icons[index % 5], color: colors[index % 5]),
                  ),
                  title: Text('항목 ${index + 1}'),
                  subtitle: Text('ListView.builder로 생성된 항목'),
                  trailing: Chip(
                    label: Text('#${index + 1}'),
                    backgroundColor: colors[index % 5].withOpacity(0.2),
                    labelStyle: TextStyle(
                      color: colors[index % 5],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
