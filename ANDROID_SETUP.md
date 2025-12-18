# Flutter 앱 Android 에뮬레이터에서 실행하기

## 🎯 목표

Android 에뮬레이터에서 Flutter 학습 앱을 실행하여 테스트합니다.

## ✅ 사전 준비사항

- [x] Flutter SDK 설치
- [x] Android Studio 설치
- [x] Android 에뮬레이터 생성
- [ ] Android SDK Command-line Tools 설치 **← 필요!**

---

## 📱 실행 단계

### 1단계: Android SDK Command-line Tools 설치

#### Android Studio에서 설치:

1. **Android Studio 실행**

2. **SDK Manager 열기**

   - 상단 메뉴: `Tools` → `SDK Manager`
   - 또는 Welcome 화면에서 `More Actions` → `SDK Manager`

3. **SDK Tools 탭 클릭**

4. **다음 항목 체크**:

   - ✅ `Android SDK Command-line Tools (latest)`
   - ✅ `Android SDK Build-Tools` (자동 선택됨)
   - ✅ `Android SDK Platform-Tools` (자동 선택됨)

5. **Apply 버튼 클릭** → 설치 대기 (2-3분)

6. **OK 클릭**하여 완료

---

### 2단계: Android 라이선스 동의

터미널(PowerShell 또는 CMD)에서:

```bash
flutter doctor --android-licenses
```

- 여러 번 `y` 입력하여 모든 라이선스 동의
- "All SDK package licenses accepted" 메시지 확인

---

### 3단계: Flutter Doctor 확인

```bash
flutter doctor
```

**확인 사항**:

- ✅ `[√] Flutter`
- ✅ `[√] Android toolchain` **← 이제 체크 표시되어야 함!**
- ✅ `[√] Chrome`
- ✅ `[√] Visual Studio`
- ✅ `[√] Android Studio`

---

### 4단계: Android 에뮬레이터 실행

#### 방법 A: Android Studio에서 실행

1. Android Studio 실행
2. 상단 `Device Manager` 클릭
3. `Medium Phone API 36.1` 옆의 `▶️` 버튼 클릭
4. 에뮬레이터 창이 열릴 때까지 대기 (1-2분)

#### 방법 B: 명령줄에서 실행

```bash
# 사용 가능한 에뮬레이터 확인
flutter emulators

# 에뮬레이터 실행
flutter emulators --launch Medium_Phone_API_36.1
```

---

### 5단계: Flutter 앱 실행 🚀

에뮬레이터가 실행된 상태에서:

```bash
cd "경로\flutter-sample"
flutter run
```

또는 전체 경로 사용:

```bash
"C:\Users\nenya\OneDrive\바탕 화면\flutter\bin\flutter" run
```

**예상 결과**:

```
Launching lib\main.dart on sdk gphone64 x86 64 in debug mode...
Running Gradle task 'assembleDebug'...
✓ Built build\app\outputs\flutter-apk\app-debug.apk.
Installing build\app\outputs\apk\app.apk...
Flutter run key commands.
r Hot reload. 🔥🔥🔥
```

---

## 🎮 앱 실행 중 명령어

앱이 실행되면 터미널에서 다음 키를 사용할 수 있습니다:

- `r` - **Hot Reload** (코드 수정 즉시 반영) ⚡
- `R` - **Hot Restart** (앱 완전 재시작)
- `h` - 도움말 표시
- `q` - 앱 종료

---

## 🔧 문제 해결

### 문제 1: "Gradle task assembleDebug failed"

**원인**: cmdline-tools 미설치

**해결**:

1. Android Studio → SDK Manager
2. SDK Tools → Android SDK Command-line Tools 설치

---

### 문제 2: 에뮬레이터가 보이지 않음

**확인**:

```bash
flutter devices
```

**해결**:

- Android Studio에서 에뮬레이터를 수동으로 실행
- 에뮬레이터가 완전히 부팅될 때까지 대기 (홈 화면이 보여야 함)

---

### 문제 3: "Unable to locate Android SDK"

**해결**:

```bash
flutter doctor -v
```

출력에서 Android SDK 경로 확인 후:

```bash
flutter config --android-sdk "C:\Users\사용자명\AppData\Local\Android\Sdk"
```

---

## 📊 첫 빌드 시간

- **첫 빌드**: 2-5분 (Gradle dependencies 다운로드)
- **이후 빌드**: 10-30초
- **Hot Reload**: 1-2초 ⚡

---

## ✅ 체크리스트

실행 전 확인:

- [ ] cmdline-tools 설치됨
- [ ] 라이선스 동의 완료 (`flutter doctor --android-licenses`)
- [ ] Android 에뮬레이터 실행 중
- [ ] 프로젝트 디렉토리에서 실행

---

## 🎉 성공!

앱이 에뮬레이터에서 실행되면:

1. "Flutter 학습 앱" 화면이 보입니다
2. 코드를 수정하고 `r` 키로 Hot Reload 테스트
3. 예제 파일들을 추가하여 학습 시작!

---

**작성일**: 2025-12-18  
**테스트 환경**: Windows 10, Android Studio Ladybug, Flutter 3.38.5
