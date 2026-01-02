# Flutter 학습 가이드

## 🎯 학습 목표

이 문서는 Flutter 학습 프로젝트를 효과적으로 활용하는 방법을 안내합니다.

## 📋 사전 준비사항

### 1. Flutter SDK 설치 확인

```bash
flutter doctor
```

위 명령어를 실행하여 Flutter 환경이 올바르게 설정되었는지 확인하세요.

### 2. 에디터 설정

- **VS Code**: Flutter 확장 프로그램 설치
- **Android Studio**: Flutter 플러그인 설치

## 🚀 프로젝트 시작하기

### 1. 프로젝트 실행

```bash
# 의존성 설치
flutter pub get

# 앱 실행
flutter run

# 또는 전체 경로 사용
"C:\Users\nenya\OneDrive\바탕 화면\flutter\bin\flutter" run
```

### 2. Hot Reload 사용하기

앱이 실행 중일 때:

- `r` 키: Hot Reload (빠른 리로드)
- `R` 키: Hot Restart (완전한 재시작)
- `q` 키: 앱 종료

## 📚 예제별 학습 가이드

### 예제 1: 기본 위젯 (Basic Widgets)

**학습 시간**: 30-45분

**핵심 개념**:

- Text 위젯의 스타일링
- Container의 decoration 속성
- Row와 Column을 사용한 레이아웃
- Icon 위젯 사용법

**실습 과제**:

1. Text 위젯의 색상을 다른 색으로 변경해보세요
2. Container에 다른 그라디언트 색상을 적용해보세요
3. Row의 mainAxisAlignment를 변경하여 정렬을 바꿔보세요
4. 새로운 아이콘을 추가해보세요 (Icons.camera, Icons.settings 등)

**참고 자료**:

- [Text 위젯 문서](https://api.flutter.dev/flutter/widgets/Text-class.html)
- [Container 위젯 문서](https://api.flutter.dev/flutter/widgets/Container-class.html)
- [Layout 가이드](https://docs.flutter.dev/development/ui/layout)

---

### 예제 2: 상태 관리 (Stateful Widget)

**학습 시간**: 45-60분

**핵심 개념**:

- StatelessWidget vs StatefulWidget
- setState() 메서드의 역할
- 사용자 이벤트 처리
- UI 상태 관리

**실습 과제**:

1. 카운터의 증감 값을 1에서 5로 변경해보세요
2. 새로운 색상 버튼을 추가해보세요
3. 슬라이더의 최솟값과 최댓값을 변경해보세요
4. 좋아요 버튼을 클릭할 때 애니메이션을 추가해보세요

**주요 코드 패턴**:

```dart
// 상태 업데이트
setState(() {
  _counter++;  // 상태 변수 변경
});
```

**참고 자료**:

- [StatefulWidget 문서](https://api.flutter.dev/flutter/widgets/StatefulWidget-class.html)
- [상태 관리 소개](https://docs.flutter.dev/development/data-and-backend/state-mgmt/intro)

---

### 예제 3: 리스트 뷰 (List View)

**학습 시간**: 45-60분

**핵심 개념**:

- ListView vs ListView.builder
- GridView 사용법
- 동적 데이터 표시
- 효율적인 스크롤 처리

**실습 과제**:

1. 과일 목록에 새로운 항목을 추가해보세요
2. GridView의 crossAxisCount를 변경하여 열 개수를 바꿔보세요
3. ListView.builder의 항목 개수를 200개로 늘려보세요
4. ListTile에 onTap 이벤트를 추가하여 클릭 시 동작을 구현해보세요

**주요 코드 패턴**:

```dart
// 효율적인 리스트 생성
ListView.builder(
  itemCount: 100,
  itemBuilder: (context, index) {
    return ListTile(
      title: Text('항목 $index'),
    );
  },
)
```

**참고 자료**:

- [ListView 문서](https://api.flutter.dev/flutter/widgets/ListView-class.html)
- [GridView 문서](https://api.flutter.dev/flutter/widgets/GridView-class.html)

---

### 예제 4: 화면 전환 (Navigation)

**학습 시간**: 60-90분

**핵심 개념**:

- Navigator.push()와 Navigator.pop()
- MaterialPageRoute
- 화면 간 데이터 전달
- 비동기 결과 받기
- 커스텀 페이지 전환 애니메이션

**실습 과제**:

1. 새로운 화면을 만들어 추가해보세요
2. 데이터를 전달하는 다른 예제를 만들어보세요
3. 다른 페이지 전환 애니메이션을 시도해보세요 (FadeTransition, ScaleTransition)
4. Named Routes를 사용한 내비게이션을 구현해보세요

**주요 코드 패턴**:

```dart
// 화면 이동
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => SecondScreen()),
);

// 이전 화면으로 돌아가기
Navigator.pop(context);

// 결과와 함께 돌아가기
Navigator.pop(context, '선택한 값');
```

**참고 자료**:

- [Navigation 가이드](https://docs.flutter.dev/cookbook/navigation/navigation-basics)
- [Navigator 문서](https://api.flutter.dev/flutter/widgets/Navigator-class.html)

---

### 예제 5: 폼과 입력 (Forms)

**학습 시간**: 60-90분

**핵심 개념**:

- TextField와 TextEditingController
- Form과 FormField
- Validation (입력 검증)
- 다양한 입력 위젯 (Checkbox, Radio, Slider)

**실습 과제**:

1. 새로운 입력 필드를 추가해보세요 (전화번호, 주소 등)
2. 비밀번호 확인 필드를 추가하고 일치 여부를 검증해보세요
3. 다른 정규식을 사용한 검증을 추가해보세요
4. 드롭다운 메뉴를 추가해보세요

**주요 코드 패턴**:

```dart
// TextFormField with validation
TextFormField(
  controller: _controller,
  decoration: InputDecoration(labelText: '이메일'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '이메일을 입력해주세요';
    }
    return null;
  },
)

// Form validation
if (_formKey.currentState!.validate()) {
  // 폼이 유효할 때 실행
}
```

**참고 자료**:

- [Form 가이드](https://docs.flutter.dev/cookbook/forms/validation)
- [TextField 문서](https://api.flutter.dev/flutter/material/TextField-class.html)

## 💡 학습 팁

### 1. 적극적으로 실험하기

- 코드를 변경하고 Hot Reload를 사용하여 즉시 결과를 확인하세요
- 예상한 대로 동작하지 않아도 괜찮습니다 - 이것이 학습입니다!

### 2. 문서 읽기

- 모르는 위젯이 나오면 공식 문서를 참고하세요
- 각 위젯의 속성들을 하나씩 시도해보세요

### 3. 에러 메시지 이해하기

- Flutter의 에러 메시지는 매우 상세합니다
- 에러 메시지를 천천히 읽고 문제를 파악하세요
- 디버그 콘솔을 주의 깊게 확인하세요

### 4. 작은 단위로 학습하기

- 한 번에 많은 것을 배우려 하지 마세요
- 하나의 개념을 완전히 이해한 후 다음으로 넘어가세요
- 각 예제를 충분히 실습한 후 다음 예제로 진행하세요

### 5. 스스로 프로젝트 만들기

- 기본 예제들을 이해했다면, 간단한 앱을 직접 만들어보세요
- 추천 프로젝트:
  - 할 일 목록 앱
  - 간단한 계산기
  - 명언 앱
  - 날씨 앱 (API 연동)

## 🔍 디버깅 팁

### 1. Flutter DevTools 사용

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### 2. 로그 출력

```dart
print('디버그 메시지: $_counter');
debugPrint('상세한 디버그 정보');
```

### 3. 위젯 인스펙터

- DevTools의 Widget Inspector를 사용하여 UI 구조를 확인하세요

## 📝 체크리스트

학습을 마친 후 아래 항목들을 확인해보세요:

- [ ] StatelessWidget과 StatefulWidget의 차이를 이해했나요?
- [ ] setState()가 언제, 왜 필요한지 알고 있나요?
- [ ] Row와 Column의 차이를 설명할 수 있나요?
- [ ] Navigator를 사용하여 화면을 전환할 수 있나요?
- [ ] Form validation을 구현할 수 있나요?
- [ ] ListView.builder를 언제 사용해야 하는지 이해했나요?
- [ ] 에러 메시지를 읽고 해결할 수 있나요?

## 🎯 다음 학습 주제

이 프로젝트를 완료했다면, 다음 주제들을 학습해보세요:

1. **상태 관리 패턴**

   - Provider
   - Riverpod
   - Bloc

2. **네트워크 통신**

   - http 패키지
   - REST API 연동
   - JSON 파싱

3. **로컬 데이터 저장**

   - shared_preferences
   - sqflite (SQLite)
   - Hive

4. **Firebase 연동**

   - Authentication
   - Firestore
   - Cloud Storage

5. **고급 UI**
   - 애니메이션
   - 커스텀 위젯
   - 반응형 디자인

## 🆘 도움이 필요할 때

- [Flutter 공식 Discord](https://discord.gg/flutter)
- [Stack Overflow - Flutter 태그](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter 한국 커뮤니티](https://flutter-ko.dev/)
- [Reddit r/FlutterDev](https://www.reddit.com/r/FlutterDev/)

## 🎉 성공적인 학습을 기원합니다!

Flutter는 강력하고 재미있는 프레임워크입니다.
꾸준히 연습하면 멋진 앱을 만들 수 있을 거예요! 🚀
