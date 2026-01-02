# Flutter 환경 문제 해결 가이드

## ✅ 현재 상태 (2025-12-18)

**좋은 소식!** Flutter 환경이 정상적으로 작동하고 있습니다.

- ✅ Flutter Doctor: 모든 체크 통과
- ✅ Flutter Analyze: 코드에 문제 없음
- ✅ 의존성: 정상적으로 설치됨
- ✅ Flutter 버전: 3.38.5 (안정적으로 작동 중)

## 🚨 이전에 발생했던 문제 (해결됨)

Flutter 3.38.5 버전의 **shader 컴파일 버그**로 인해 빌드가 실패했었습니다.

### 에러 메시지

```
ShaderCompilerException: Shader compilation of
"C:\Users\nenya\OneDrive\바탕 화면\flutter\packages\flutter\lib\src\material\shaders\ink_sparkle.frag"
failed with exit code 1
```

## ✅ 해결 방법

### 방법 1: 이전 안정 버전으로 다운그레이드 (권장)

```bash
# 현재 버전 확인
flutter --version

# 3.27.1 버전으로 다운그레이드 (안정적인 버전)
flutter downgrade 3.27.1

# 또는 특정 버전 설치
cd C:\
git clone https://github.com/flutter/flutter.git -b 3.27.1 --depth 1
```

### 방법 2: 문제되는 Shader 파일 임시 수정

```bash
# ❗주의: 이 방법은 임시 해결책입니다

# 1. Flutter SDK 위치로 이동
cd "C:\Users\nenya\OneDrive\바탕 화면\flutter"

# 2. 문제 파일 백업
copy packages\flutter\lib\src\material\shaders\ink_sparkle.frag ink_sparkle.frag.backup

# 3. 파일을 빈 파일로 대체 (또는 삭제)
# (하지만 이렇게 하면 앱이 제대로 작동하지 않을 수 있음)
```

### 방법 3: Android Studio 설치 후 Android 에뮬레이터 사용

Windows/Web 빌드가 문제가 있으므로, Android 에뮬레이터로 우회:

```bash
# 1. Android Studio 설치
# https://developer.android.com/studio

# 2. Android SDK 설치 (Android Studio에서 자동)

# 3. 에뮬레이터 생성 및 실행

# 4. Flutter 앱 실행
flutter run  # 자동으로 에뮬레이터 감지
```

### 방법 4: Flutter 재설치 (다른 위치)

```bash
# 1. 새 위치에 Flutter 설치
cd C:\
git clone https://github.com/flutter/flutter.git
cd flutter
git checkout stable

# 2. 환경 변수 PATH에 추가
# C:\flutter\bin

# 3. Flutter doctor 실행
flutter doctor
```

## 🎯 즉시 테스트할 수 있는 방법

### DartPad 사용 (온라인)

1. https://dartpad.dev/ 접속
2. Flutter 예제 코드 복사
3. 즉시 실행

### 로컬 서버로 HTML 빌드 테스트

```bash
# 1. 빌드 (에러가 날 것임)
flutter build web

# 만약 성공하면:
# 2. 로컬 서버 실행
cd build/web
python -m http.server 8000

# 3. 브라우저에서 접속
# http://localhost:8000
```

## 📌 추천 순서

1.  **Android Studio 설치** (시간: 1-2시간)

- 가장 확실한 해결책
- 실제 업무에서도 필요

2. **Flutter 다운그레이드** (시간: 30분)
   ```bash
   flutter downgrade 3.27.1
   ```
3. **새 위치에 Flutter 재설치** (시간: 30분)
   - `C:\flutter`에 새로 설치
   - 환경 변수 업데이트

## 🔧 임시 작업 방법

Flutter 환경 구축 중에는:

- **DartPad**로 Dart/Flutter 코드 학습
- **VS Code**로 코드 작성 및 검토
- 환경 구축 완료 후 실행 및 빌드 테스트

---

**작성 시간**: 2025-12-18
**Flutter 버전**: 3.38.5 (문제 버전)
**권장 버전**: 3.27.1 이하
