# 📦 Flutter 빌드 결과물 및 배포 가이드

## 🎯 현재 빌드된 파일 위치

### Android APK (개발/디버그 버전)

```
C:\dev\flutter-sample\build\app\outputs\flutter-apk\app-debug.apk
크기: 약 74MB
```

이 파일을 Android 기기에 직접 설치할 수 있습니다!

---

## 📱 플랫폼별 빌드 결과물

### 1️⃣ **Android**

#### 개발용 (Debug) - 현재 빌드된 파일

```bash
flutter build apk --debug
```

**결과물**: `build/app/outputs/flutter-apk/app-debug.apk`

- ✅ 테스트용
- ⚠️ 파일 크기 큼 (~74MB)
- ⚠️ 디버깅 정보 포함

#### 배포용 (Release) ⭐ **Play Store에 올릴 파일**

```bash
flutter build apk --release
```

**결과물**: `build/app/outputs/flutter-apk/app-release.apk`

- ✅ 최적화됨
- ✅ 파일 크기 작음 (~20-30MB)
- ✅ 서명 필요 (배포 시)

#### App Bundle (권장) ⭐ **Play Store 권장 형식**

```bash
flutter build appbundle --release
```

**결과물**: `build/app/outputs/bundle/release/app-release.aab`

- ✅ Google Play Store에서 사용자별 최적화 APK 생성
- ✅ 더 작은 다운로드 크기
- 📝 Play Store에 이 파일을 업로드

---

### 2️⃣ **iOS** (Mac에서만 빌드 가능)

#### 개발용

```bash
flutter build ios --debug
```

**결과물**: `build/ios/iphoneos/Runner.app`

#### 배포용 ⭐ **App Store에 올릴 파일**

```bash
flutter build ipa --release
```

**결과물**: `build/ios/ipa/*.ipa`

- 📝 App Store Connect에 업로드

---

### 3️⃣ **Web**

#### 배포용 빌드

```bash
flutter build web --release
```

**결과물**: `build/web/` 폴더 전체

```
build/web/
  ├── index.html
  ├── main.dart.js
  ├── flutter.js
  ├── assets/
  └── ...
```

- 📤 **이 폴더를 웹 서버에 업로드**
- ✅ Firebase Hosting, Netlify, Vercel 등에 배포

---

### 4️⃣ **Windows**

#### 배포용 빌드

```bash
flutter build windows --release
```

**결과물**: `build/windows/x64/runner/Release/` 폴더 전체

```
build/windows/x64/runner/Release/
  ├── flutter_learning_app.exe  ⭐ 실행 파일
  ├── flutter_windows.dll
  ├── data/
  └── ...
```

- 📦 **전체 폴더를 압축하여 배포** (ZIP)
- ✅ 또는 인스톨러 생성 (MSIX 등)

---

## 🚀 배포 플랫폼별 가이드

### 📱 **Google Play Store** (Android)

#### 1단계: Release 빌드 생성

```bash
flutter build appbundle --release
```

#### 2단계: 앱 서명 (키 생성)

```bash
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

#### 3단계: `android/key.properties` 파일 생성

```properties
storePassword=<비밀번호>
keyPassword=<키 비밀번호>
keyAlias=upload
storeFile=<키스토어 파일 경로>
```

#### 4단계: Play Console에 업로드

- **파일**: `build/app/outputs/bundle/release/app-release.aab`
- Google Play Console → 새 앱 만들기 → AAB 업로드

---

### 🍎 **App Store** (iOS)

#### 1단계: Release 빌드

```bash
flutter build ipa --release
```

#### 2단계: App Store Connect에 업로드

- Xcode Organizer 사용
- 또는 Transporter 앱 사용
- **파일**: `build/ios/ipa/*.ipa`

---

### 🌐 **웹 호스팅**

#### Firebase Hosting (권장)

```bash
# 1. Firebase CLI 설치
npm install -g firebase-tools

# 2. Firebase 로그인
firebase login

# 3. Firebase 초기화
firebase init hosting

# 4. 빌드
flutter build web --release

# 5. 배포
firebase deploy --only hosting
```

#### Netlify / Vercel

1. `flutter build web --release` 실행
2. `build/web` 폴더를 드래그 앤 드롭
3. 완료! 🎉

---

### 💻 **Windows (직접 배포)**

#### 방법 1: ZIP 압축

```bash
flutter build windows --release
# build/windows/x64/runner/Release/ 폴더를 압축
```

#### 방법 2: MSIX 인스톨러 (Microsoft Store)

```bash
# pubspec.yaml에 msix_config 추가 후
flutter pub run msix:create
```

**결과물**: `build/windows/x64/runner/Release/*.msix`

---

## ⚡ 빠른 명령어 요약

```bash
# Android (Play Store)
flutter build appbundle --release

# iOS (App Store)
flutter build ipa --release

# Web (호스팅)
flutter build web --release

# Windows (실행 파일)
flutter build windows --release

# 현재 디버그 APK 확인
ls build/app/outputs/flutter-apk/
```

---

## 📊 파일 크기 비교

| 플랫폼      | Debug | Release | 비고            |
| ----------- | ----- | ------- | --------------- |
| Android APK | ~74MB | ~20MB   | 최적화됨        |
| Android AAB | -     | ~15MB   | Play Store 권장 |
| iOS IPA     | ~60MB | ~25MB   | App Store용     |
| Web         | ~10MB | ~5MB    | 압축 후         |
| Windows     | ~50MB | ~30MB   | 전체 폴더       |

---

## 🎯 **지금 당장 테스트하려면?**

### Android 기기에 설치 (현재 빌드된 파일)

```bash
# 방법 1: adb 사용
adb install build/app/outputs/flutter-apk/app-debug.apk

# 방법 2: 직접 전송
# app-debug.apk 파일을 휴대폰으로 전송하여 설치
```

### Release 버전 빌드 (최적화)

```bash
flutter build apk --release
# → build/app/outputs/flutter-apk/app-release.apk 생성 (약 20MB)
```

---

## 💡 팁

1. **개발 중**: `flutter run` 사용 (빠름)
2. **테스트 배포**: `flutter build apk --release` (APK)
3. **Play Store 배포**: `flutter build appbundle --release` (AAB)
4. **웹 배포**: `flutter build web --release` + Firebase/Netlify
5. **서명 관리**: 키스토어 파일 **백업 필수!** (분실 시 앱 업데이트 불가)

---

현재 빌드된 파일:

- **위치**: `C:\dev\flutter-sample\build\app\outputs\flutter-apk\app-debug.apk`
- **크기**: 74.5 MB
- **용도**: 개발/테스트용
- **설치 방법**: Android 기기로 전송 후 직접 설치 가능
