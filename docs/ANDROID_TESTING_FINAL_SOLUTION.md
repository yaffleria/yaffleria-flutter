# 🎯 Android 에뮬레이터 테스트 - 최종 해결 방법

## 현재 상황 요약

1. **Flutter 3.38.5**: Shader 버그로 Android/Windows 빌드 불가
2. **Flutter 3.24.0, 3.22.0**: 동일한 shader 문제 발생
3. **프로젝트 경로**: 한글 포함 ("바탕 화면")

## ✅ 권장 해결책

### 방법 1: 웹 브라우저 사용 (가장 빠름!) ⭐⭐⭐

**이미 정상 작동 중입니다!**

```bash
cd "C:\Users\nenya\OneDrive\바탕 화면\git\flutter-sample"

# Flutter SDK를 3.38.5로 되돌리기
cd C:\flutter
git checkout 3.38.5

# 프로젝트로 돌아가서 웹 실행
cd "C:\Users\nenya\OneDrive\바탕 화면\git\flutter-sample"
flutter pub get
flutter run -d chrome
```

**장점:**

- ✅ 즉시 사용 가능
- ✅ 모든 예제 정상 작동
- ✅ Hot Reload 지원
- ✅ 실제 Flutter API 사용

### 방법 2: Android 빌드 완전 해결 (시간 필요 2-3시간)

이 방법은 시간이 걸리지만 **확실합니다**.

#### 1단계: 프로젝트를 한글 없는 경로로 이동

```bash
# 새 폴더 생성 (한글 없는 경로)
mkdir C:\dev
mkdir C:\dev\projects

# 프로젝트 복사
xcopy "C:\Users\nenya\OneDrive\바탕 화면\git\flutter-sample" "C:\dev\projects\flutter-sample" /E /I /H

# 새 위치로 이동
cd C:\dev\projects\flutter-sample
```

#### 2단계: Flutter SDK 다시 설치

```bash
# 깨끗한 Flutter 설치를 위해 기존 것 제거 (선택사항)
# C:\flutter 폴더를 C:\flutter_old로 이름 변경

# 새 위치에 Flutter 설치
cd C:\
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Flutter doctor 실행
C:\flutter\bin\flutter doctor
```

#### 3단계: 환경 변수 확인

Path 환경 변수에 `C:\flutter\bin`이 있는지 확인

#### 4단계: pubspec.yaml 수정 및 빌드

```bash
cd C:\dev\projects\flutter-sample

# pubspec.yaml의 SDK 버전을 현재 Flutter에 맞게 수정
# sdk: ^3.5.0 (또는 현재 버전)

flutter pub get
flutter run
```

## 🎯 실전 추천

**학습이 목적이라면:**

- ✅ **방법 1 사용 (웹 브라우저)**
- 모든 Flutter 기능을 학습할 수 있습니다
- Android 특화 기능이 필요할 때만 방법 2 고려

**프로덕션 앱 개발이 목적이라면:**

- ✅ **방법 2 사용 (완전 해결)**
- 시간 투자 가치가 있습니다
- 모든 플랫폼에서 테스트 가능

## 📝 빠른 명령어 요약

### 현재 상태로 웹에서 실행:

```bash
# Flutter 3.38.5로 복원
cd C:\flutter
git checkout stable
git pull

# 프로젝트 실행
cd "C:\Users\nenya\OneDrive\바탕 화면\git\flutter-sample"
flutter clean
flutter pub get
flutter run -d chrome
```

### pub spec.yaml 수정사항:

```yaml
environment:
  sdk: ^3.10.4 # Flutter 3.38.5용

dev_dependencies:
  flutter_lints: ^6.0.0 # Flutter 3.38.5용
```

---

**결론**: 웹 브라우저로 학습하시고, 본격적인 앱 개발이 필요할 때 환경을 재구성하는 것을 추천드립니다!
