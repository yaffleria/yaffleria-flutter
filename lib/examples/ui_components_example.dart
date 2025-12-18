import 'package:flutter/material.dart';

/// UI 컴포넌트 예제
///
/// 자주 사용하는 UI 패턴들:
/// - Alert Dialog (경고창)
/// - Bottom Sheet (하단 시트)
/// - SnackBar (토스트 메시지)
/// - Bottom Navigation Bar (하단 탭)
/// - Modal/Popup
class UIComponentsExample extends StatefulWidget {
  const UIComponentsExample({super.key});

  @override
  State<UIComponentsExample> createState() => _UIComponentsExampleState();
}

class _UIComponentsExampleState extends State<UIComponentsExample> {
  int _selectedIndex = 0;

  // Bottom Navigation Bar용 페이지들
  final List<Widget> _pages = [
    const _DialogsPage(),
    const _BottomSheetsPage(),
    const _SnackBarsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI 컴포넌트'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      // Bottom Navigation Bar로 전환되는 페이지
      body: _pages[_selectedIndex],

      // 📱 Bottom Navigation Bar (하단 탭 네비게이션)
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.message), label: '다이얼로그'),
          BottomNavigationBarItem(
            icon: Icon(Icons.vertical_align_bottom),
            label: '바텀시트',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '스낵바',
          ),
        ],
      ),
    );
  }
}

// ==================== 1. Dialogs (Alert) 페이지 ====================
class _DialogsPage extends StatelessWidget {
  const _DialogsPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          '🔔 Alert Dialogs',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          '사용자에게 중요한 정보를 전달하거나 확인을 받을 때 사용합니다.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),

        // 기본 Alert Dialog
        _buildButton(
          context,
          title: '기본 Alert Dialog',
          icon: Icons.info,
          color: Colors.blue,
          onPressed: () => _showBasicDialog(context),
        ),
        const SizedBox(height: 12),

        // 확인/취소 Dialog
        _buildButton(
          context,
          title: '확인/취소 Dialog',
          icon: Icons.help,
          color: Colors.orange,
          onPressed: () => _showConfirmDialog(context),
        ),
        const SizedBox(height: 12),

        // 선택 Dialog
        _buildButton(
          context,
          title: '선택 Dialog',
          icon: Icons.list,
          color: Colors.purple,
          onPressed: () => _showChoiceDialog(context),
        ),
        const SizedBox(height: 12),

        // 커스텀 Dialog
        _buildButton(
          context,
          title: '커스텀 Dialog',
          icon: Icons.star,
          color: Colors.pink,
          onPressed: () => _showCustomDialog(context),
        ),
      ],
    );
  }

  void _showBasicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('알림'),
        content: const Text('이것은 기본 Alert Dialog입니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: const Text('정말로 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('삭제되었습니다')));
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }

  void _showChoiceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('색상 선택'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dialogOption(context, '빨강', Colors.red),
            _dialogOption(context, '파랑', Colors.blue),
            _dialogOption(context, '초록', Colors.green),
            _dialogOption(context, '노랑', Colors.yellow),
          ],
        ),
      ),
    );
  }

  Widget _dialogOption(BuildContext context, String label, Color color) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: color, radius: 12),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$label 색상을 선택했습니다')));
      },
    );
  }

  void _showCustomDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade300, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, size: 60, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                '축하합니다! 🎉',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '커스텀 다이얼로그를 성공적으로 열었습니다!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                ),
                child: const Text('멋져요!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== 2. Bottom Sheets 페이지 ====================
class _BottomSheetsPage extends StatelessWidget {
  const _BottomSheetsPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          '📋 Bottom Sheets',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          '화면 하단에서 올라오는 시트로, 추가 정보나 옵션을 보여줍니다.',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),

        // 기본 Bottom Sheet
        _buildButton(
          context,
          title: '기본 Bottom Sheet',
          icon: Icons.arrow_upward,
          color: Colors.green,
          onPressed: () => _showBasicBottomSheet(context),
        ),
        const SizedBox(height: 12),

        // 모달 Bottom Sheet
        _buildButton(
          context,
          title: '모달 Bottom Sheet',
          icon: Icons.view_agenda,
          color: Colors.indigo,
          onPressed: () => _showModalBottomSheet(context),
        ),
        const SizedBox(height: 12),

        // 드래그 가능한 Bottom Sheet
        _buildButton(
          context,
          title: '드래그 가능한 Sheet',
          icon: Icons.drag_handle,
          color: Colors.cyan,
          onPressed: () => _showDraggableBottomSheet(context),
        ),
        const SizedBox(height: 12),

        // 공유 Bottom Sheet (실제 앱 스타일)
        _buildButton(
          context,
          title: '공유 Bottom Sheet',
          icon: Icons.share,
          color: Colors.blueGrey,
          onPressed: () => _showShareBottomSheet(context),
        ),
      ],
    );
  }

  void _showBasicBottomSheet(BuildContext context) {
    showBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        color: Colors.green.shade50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '기본 Bottom Sheet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('화면 밖을 터치하면 닫히지 않습니다.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('닫기'),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.info, size: 48, color: Colors.indigo),
            const SizedBox(height: 16),
            const Text(
              '모달 Bottom Sheet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '화면 밖을 터치하면 자동으로 닫힙니다.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showDraggableBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '드래그 가능한 시트',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                '위아래로 드래그하여 크기를 조절할 수 있습니다!',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              ...List.generate(
                20,
                (index) => ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text('항목 ${index + 1}'),
                  subtitle: Text('스크롤 가능한 컨텐츠입니다'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showShareBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '공유하기',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _shareOption(Icons.message, '메시지', Colors.green),
                _shareOption(Icons.email, '이메일', Colors.red),
                _shareOption(Icons.link, '링크', Colors.blue),
                _shareOption(Icons.more_horiz, '더보기', Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _shareOption(IconData icon, String label, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

// ==================== 3. SnackBars 페이지 ====================
class _SnackBarsPage extends StatelessWidget {
  const _SnackBarsPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          '📢 SnackBars',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          '화면 하단에 짧은 메시지를 표시합니다. (토스트 메시지)',
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 24),

        // 기본 SnackBar
        _buildButton(
          context,
          title: '기본 SnackBar',
          icon: Icons.message,
          color: Colors.blue,
          onPressed: () => _showBasicSnackBar(context),
        ),
        const SizedBox(height: 12),

        // 성공 SnackBar
        _buildButton(
          context,
          title: '성공 SnackBar',
          icon: Icons.check_circle,
          color: Colors.green,
          onPressed: () => _showSuccessSnackBar(context),
        ),
        const SizedBox(height: 12),

        // 에러 SnackBar
        _buildButton(
          context,
          title: '에러 SnackBar',
          icon: Icons.error,
          color: Colors.red,
          onPressed: () => _showErrorSnackBar(context),
        ),
        const SizedBox(height: 12),

        // Action이 있는 SnackBar
        _buildButton(
          context,
          title: 'Action SnackBar',
          icon: Icons.undo,
          color: Colors.orange,
          onPressed: () => _showActionSnackBar(context),
        ),
        const SizedBox(height: 12),

        // 커스텀 SnackBar
        _buildButton(
          context,
          title: '커스텀 SnackBar',
          icon: Icons.auto_awesome,
          color: Colors.purple,
          onPressed: () => _showCustomSnackBar(context),
        ),
      ],
    );
  }

  void _showBasicSnackBar(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('기본 SnackBar입니다')));
  }

  void _showSuccessSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 12),
            Text('성공적으로 저장되었습니다!'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.error, color: Colors.white),
            SizedBox(width: 12),
            Text('오류가 발생했습니다'),
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showActionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('항목이 삭제되었습니다'),
        action: SnackBarAction(
          label: '실행 취소',
          textColor: Colors.yellow,
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('실행 취소되었습니다'),
                duration: Duration(seconds: 1),
              ),
            );
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void _showCustomSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '멋진 SnackBar!',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('커스텀 디자인이 적용되었습니다', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.purple,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

// ==================== 공통 버튼 위젯 ====================
Widget _buildButton(
  BuildContext context, {
  required String title,
  required IconData icon,
  required Color color,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
    ),
    child: Row(
      children: [
        Icon(icon),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        const Icon(Icons.arrow_forward_ios, size: 16),
      ],
    ),
  );
}
