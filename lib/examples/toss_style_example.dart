import 'package:flutter/material.dart';

/// 토스(Toss) 스타일 커스텀 UI 예제
///
/// Material Design 없이 순수 커스텀 스타일링
/// - 깔끔하고 미니멀한 디자인
/// - 큰 타이포그래피
/// - 부드러운 그림자와 애니메이션
/// - 토스만의 색상 팔레트
class TossStyleExample extends StatefulWidget {
  const TossStyleExample({super.key});

  @override
  State<TossStyleExample> createState() => _TossStyleExampleState();
}

class _TossStyleExampleState extends State<TossStyleExample> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TossColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 커스텀 AppBar
            _buildCustomAppBar(),

            // 메인 컨텐츠
            Expanded(
              child: _selectedTab == 0
                  ? const _HomePage()
                  : _selectedTab == 1
                  ? const _BenefitsPage()
                  : const _ProfilePage(),
            ),

            // 커스텀 Bottom Navigation
            _buildCustomBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '토스',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: TossColors.text,
            ),
          ),
          Row(
            children: [
              _buildIconButton(Icons.qr_code_scanner),
              const SizedBox(width: 12),
              _buildIconButton(Icons.notifications_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: TossColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 22, color: TossColors.text),
    );
  }

  Widget _buildCustomBottomNav() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_filled, '홈'),
          _buildNavItem(1, Icons.card_giftcard, '혜택'),
          _buildNavItem(2, Icons.person, '전체'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? TossColors.primary : TossColors.textLight,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? TossColors.primary : TossColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== 홈 페이지 ====================
class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // 잔액 카드
        _buildBalanceCard(),
        const SizedBox(height: 20),

        // 빠른 메뉴
        _buildQuickMenu(),
        const SizedBox(height: 32),

        // 섹션 제목
        const Text(
          '내 자산',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: TossColors.text,
          ),
        ),
        const SizedBox(height: 16),

        // 자산 카드들
        _buildAssetCard(
          '토스뱅크 통장',
          '1,234,567원',
          Icons.account_balance,
          TossColors.primary,
        ),
        const SizedBox(height: 12),
        _buildAssetCard(
          '토스증권 계좌',
          '5,678,900원',
          Icons.trending_up,
          Color(0xFFFF6B6B),
        ),
        const SizedBox(height: 12),
        _buildAssetCard('토스페이머니', '45,000원', Icons.loyalty, Color(0xFF4ECDC4)),
        const SizedBox(height: 32),

        // 맞춤 서비스
        const Text(
          '맞춤 서비스',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: TossColors.text,
          ),
        ),
        const SizedBox(height: 16),
        _buildServiceBanner(),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return TossCard(
      gradient: const LinearGradient(
        colors: [TossColors.primary, Color(0xFF0066FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '내 총 자산',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '7,003,467원',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildBalanceButton('송금', Icons.send)),
              const SizedBox(width: 12),
              Expanded(child: _buildBalanceButton('충전', Icons.add)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceButton(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickMenu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildQuickMenuItem(Icons.receipt_long, '송금'),
        _buildQuickMenuItem(Icons.credit_card, '결제'),
        _buildQuickMenuItem(Icons.savings, '저축'),
        _buildQuickMenuItem(Icons.more_horiz, '전체'),
      ],
    );
  }

  Widget _buildQuickMenuItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: TossColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: TossColors.text, size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: TossColors.text,
          ),
        ),
      ],
    );
  }

  Widget _buildAssetCard(
    String title,
    String amount,
    IconData icon,
    Color color,
  ) {
    return TossCard(
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: TossColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: TossColors.text,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: TossColors.textLight,
          ),
        ],
      ),
    );
  }

  Widget _buildServiceBanner() {
    return TossCard(
      gradient: const LinearGradient(
        colors: [Color(0xFFFFF4E6), Color(0xFFFFE4B5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF9F00),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '추천',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  '내게 딱 맞는\n대출 찾기',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: TossColors.text,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '최저 금리 비교하기',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: TossColors.textLight,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.trending_up, size: 60, color: Color(0xFFFF9F00)),
        ],
      ),
    );
  }
}

// ==================== 혜택 페이지 ====================
class _BenefitsPage extends StatelessWidget {
  const _BenefitsPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          '이번 달 혜택',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: TossColors.text,
          ),
        ),
        const SizedBox(height: 20),
        _buildBenefitCard(
          '커피 10% 할인',
          '스타벅스, 이디야 등',
          Icons.local_cafe,
          const Color(0xFF8B4513),
          '3,500원 절약',
        ),
        const SizedBox(height: 12),
        _buildBenefitCard(
          '편의점 2+1',
          'CU, GS25 등',
          Icons.store,
          const Color(0xFF4CAF50),
          '6,000원 절약',
        ),
        const SizedBox(height: 12),
        _buildBenefitCard(
          '영화 예매 할인',
          'CGV, 메가박스 등',
          Icons.movie,
          const Color(0xFFE91E63),
          '5,000원 절약',
        ),
      ],
    );
  }

  Widget _buildBenefitCard(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    String saved,
  ) {
    return TossCard(
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 28),
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
                    fontWeight: FontWeight.w700,
                    color: TossColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: TossColors.textLight,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: TossColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    saved,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: TossColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== 프로필 페이지 ====================
class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        TossCard(
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [TossColors.primary, Color(0xFF0066FF)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '홍길동',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: TossColors.text,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'hong@example.com',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: TossColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildMenuSection(),
      ],
    );
  }

  Widget _buildMenuSection() {
    return Column(
      children: [
        _buildMenuItem(Icons.settings, '설정'),
        _buildMenuItem(Icons.help_outline, '고객센터'),
        _buildMenuItem(Icons.info_outline, '앱 정보'),
        _buildMenuItem(Icons.logout, '로그아웃', isDestructive: true),
      ],
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String label, {
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TossCard(
        child: Row(
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : TossColors.text,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? Colors.red : TossColors.text,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDestructive
                  ? Colors.red.withOpacity(0.5)
                  : TossColors.textLight,
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== 토스 스타일 카드 위젯 ====================
class TossCard extends StatelessWidget {
  final Widget child;
  final Gradient? gradient;
  final Color? color;

  const TossCard({super.key, required this.child, this.gradient, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color ?? (gradient == null ? TossColors.cardBackground : null),
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

// ==================== 토스 컬러 팔레트 ====================
class TossColors {
  static const primary = Color(0xFF0064FF);
  static const background = Color(0xFFF9FAFB);
  static const cardBackground = Color(0xFFFFFFFF);
  static const text = Color(0xFF191F28);
  static const textLight = Color(0xFF8B95A1);
  static const divider = Color(0xFFE5E8EB);
}
