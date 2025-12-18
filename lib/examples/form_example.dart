import 'package:flutter/material.dart';

/// Form 학습 예제
/// TextField, Form, Validation 등 사용자 입력을 배웁니다.
class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isPasswordVisible = false;
  String _selectedGender = '선택 안 함';
  bool _agreeToTerms = false;
  double _satisfaction = 3.0;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('5. 폼과 입력'), elevation: 2),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              '회원가입 양식',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '다양한 입력 필드를 학습해보세요',
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),

            // 이름 입력
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: '이름',
                hintText: '이름을 입력하세요',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이름을 입력해주세요';
                }
                if (value.length < 2) {
                  return '이름은 2글자 이상이어야 합니다';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // 이메일 입력
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: '이메일',
                hintText: 'example@email.com',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '이메일을 입력해주세요';
                }
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) {
                  return '올바른 이메일 형식이 아닙니다';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // 비밀번호 입력
            TextFormField(
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력하세요',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '비밀번호를 입력해주세요';
                }
                if (value.length < 6) {
                  return '비밀번호는 6자 이상이어야 합니다';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // 성별 선택
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '성별',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 12,
                      children: ['남성', '여성', '선택 안 함'].map((gender) {
                        return ChoiceChip(
                          label: Text(gender),
                          selected: _selectedGender == gender,
                          onSelected: (selected) {
                            setState(() {
                              _selectedGender = gender;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 만족도
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '서비스 만족도',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _satisfaction = (index + 1).toDouble();
                            });
                          },
                          child: Icon(
                            index < _satisfaction
                                ? Icons.star
                                : Icons.star_border,
                            size: 40,
                            color: Colors.amber,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        '${_satisfaction.toInt()}점',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 메시지 입력
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              maxLength: 200,
              decoration: const InputDecoration(
                labelText: '메시지 (선택사항)',
                hintText: '추가로 전달하고 싶은 내용을 입력하세요',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // 약관 동의
            Card(
              child: CheckboxListTile(
                title: const Text('이용약관에 동의합니다'),
                subtitle: const Text('필수 항목입니다'),
                value: _agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    _agreeToTerms = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            const SizedBox(height: 24),

            // 제출 버튼
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('제출하기', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 12),

            // 리셋 버튼
            OutlinedButton(
              onPressed: _resetForm,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('초기화', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('입력 내용을 확인해주세요'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('이용약관에 동의해주세요'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // 성공 다이얼로그 표시
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 32),
            SizedBox(width: 12),
            Text('제출 완료'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이름: ${_nameController.text}'),
            Text('이메일: ${_emailController.text}'),
            Text('성별: $_selectedGender'),
            Text('만족도: ${_satisfaction.toInt()}점'),
            if (_messageController.text.isNotEmpty)
              Text('메시지: ${_messageController.text}'),
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
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _messageController.clear();
    setState(() {
      _selectedGender = '선택 안 함';
      _agreeToTerms = false;
      _satisfaction = 3.0;
      _isPasswordVisible = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('폼이 초기화되었습니다'),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
