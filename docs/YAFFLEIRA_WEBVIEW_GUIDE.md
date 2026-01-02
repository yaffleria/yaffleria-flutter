# Yaffleira WebView - Flutter ↔ React 통신 가이드

## 🎉 완성!

Flutter 앱에서 React WebView와 **handshake 프로토콜**을 통해 안전하게 양방향 통신하는 샘플이 완성되었습니다!

## 📱 테스트 방법

### 1. React 개발 서버 실행 (이미 실행 중)

```bash
cd c:\dev\yaffleria-workspace\apps\webview-sample
pnpm dev
```

✅ http://localhost:5173 에서 실행 중

### 2. Flutter 앱 실행

```bash
cd c:\dev\yaffleria-flutter
flutter run -d emulator-5554
```

### 3. 앱에서 WebView 열기

1. Flutter 앱 메인 화면에서 **"9. 🚀 Yaffleira WebView"** 카드 클릭
2. WebView 페이지가 열리고 자동으로 handshake 시작!
3. 성공 시 ✅ 초록색 체크 아이콘과 "Handshake 완료!" 스낵바 표시

## 🔌 Handshake 프로세스

```
1. WebView 로드 완료
   ↓
2. Flutter → React: handshake 메시지 (deviceInfo 포함)
   ↓
3. React → Flutter: handshake 응답
   ↓
4. Flutter → React: ready 신호
   ↓
5. ✅ 통신 가능!
```

### 타이밍 보장

- **Flutter**: `onPageFinished`에서 handshake 시작
- **React**: `useEffect`에서 handshake 대기
- **양방향 확인**: 서로 준비되었음을 확인 후 통신 시작
- **Timeout**: 5초 내 응답 없으면 에러 처리

## 🎯 테스트 가능한 기능

### React WebView에서 테스트 가능한 액션들:

1. **💬 Toast 표시**

   - 클릭 → Flutter 스낵바로 메시지 표시

2. **🌐 URL 열기**

   - 클릭 → Flutter에서 스낵바로 확인

3. **🧭 페이지 이동**

   - 클릭 → Flutter에서 스낵바로 확인

4. **📤 공유하기**

   - 클릭 → Flutter에서 스낵바로 표시

5. **📱 디바이스 정보 요청**

   - 클릭 → React에 디바이스 정보 반환

6. **❌ WebView 닫기**
   - 클릭 → Flutter WebView 페이지 닫힘

## 📊 상태 모니터링

### Flutter AppBar

- **숫자 배지**: 송수신한 메시지 개수 표시
- **초록 체크**: Handshake 완료 상태
- **로딩 인디케이터**: 페이지 로딩 중
- **새로고침 버튼**: WebView 새로고침

### FloatingActionButton (연결 후)

- "상태" 버튼 클릭 시 통신 상태 다이얼로그 표시
  - Handshake 상태
  - 메시지 송수신 개수
  - 플랫폼 정보
  - URL

## 🔍 디버깅

### Flutter Console

모든 메시지 교환이 로그로 출력됩니다:

```
[Flutter] 🚀 Sending handshake...
[Flutter] 📤 Sent to WebView: handshake (id: handshake_1234567890)
[Flutter] ✉️ Received from WebView: {"id":"msg_...","type":"handshake",...}
[Flutter] 🤝 WebView handshake received
[Flutter] 📤 Sent to WebView: ready (id: ready_1234567891)
[Flutter] 🎯 Handling action: showToast with params: {message: Hello!}
```

### React Console (Browser DevTools)

```
[WebViewBridge] Initialized
[WebViewBridge] Starting handshake...
[WebViewBridge] Received from Native: {type: "handshake", ...}
[WebViewBridge] Native handshake received
[WebViewBridge] ✅ Handshake completed!
```

## 📝 메시지 프로토콜

### 메시지 구조

```typescript
{
  id: "msg_1234567890_abc123",
  type: "handshake" | "ready" | "action" | "response",
  payload: {...},
  timestamp: 1234567890000
}
```

### Handshake 메시지

**Flutter → React:**

```json
{
  "id": "handshake_xxx",
  "type": "handshake",
  "payload": {
    "deviceInfo": {
      "platform": "android",
      "osVersion": "Android 16",
      "appVersion": "1.0.0",
      "deviceModel": "linux",
      "deviceId": "device_xxx"
    }
  }
}
```

**React → Flutter:**

```json
{
  "id": "msg_xxx",
  "type": "handshake",
  "payload": {
    "source": "web"
  }
}
```

**Flutter → React (Ready):**

```json
{
  "id": "ready_xxx",
  "type": "ready"
}
```

### Action 요청-응답

**React → Flutter (요청):**

```json
{
  "id": "msg_xxx",
  "type": "action",
  "payload": {
    "action": "showToast",
    "params": {
      "message": "Hello!"
    }
  }
}
```

**Flutter → React (응답):**

```json
{
  "id": "msg_xxx",
  "type": "response",
  "payload": {
    "success": true,
    "data": null,
    "error": null
  }
}
```

## 🛠️ 트러블슈팅

### "Handshake timeout" 에러

**원인**: React 개발 서버가 실행되지 않음

**해결**:

```bash
cd c:\dev\yaffleria-workspace\apps\webview-sample
pnpm dev
```

### "ERR_CONNECTION_REFUSED" 에러

**원인**: localhost:5173 접근 불가

**해결**:

1. React 서버 실행 확인
2. 브라우저에서 http://localhost:5173 접속 테스트
3. Flutter 앱 새로고침

### WebView가 빈 화면으로 표시됨

**원인**: Android 에뮬레이터의 네트워크 설정

**해결**:

1. 에뮬레이터 재시작
2. Flutter 앱 재실행
3. WebView 새로고침 버튼 클릭

## 🎨 주요 구현 파일

### Flutter (Native)

- `lib/examples/yaffleira_webview_example.dart`
  - WebViewController 설정
  - JavaScript Channel 등록 (`FlutterBridge`)
  - Handshake 로직
  - Action 핸들러들
  - UI (AppBar, FAB, 상태 표시)

### React (WebView)

- `src/bridge/WebViewBridge.ts`

  - 브릿지 클래스
  - Handshake 시작
  - 메시지 송수신
  - 타임아웃 처리

- `src/hooks/useWebViewBridge.ts`

  - React Hook
  - 상태 관리
  - 액션 헬퍼 함수들

- `src/App.tsx`
  - UI 컴포넌트
  - 액션 버튼들
  - 상태 표시

## 🚀 성공 지표

✅ **Handshake 완료**

- Flutter AppBar에 초록 체크 아이콘 표시
- "Handshake 완료!" 스낵바 표시
- React UI에 "연결됨" 배지 표시

✅ **양방향 통신**

- React 버튼 클릭 → Flutter 스낵바 표시
- 메시지 카운터 증가

✅ **타이밍 이슈 없음**

- Native/WebView 중 어느 쪽이 먼저 로드되어도 정상 작동
- Handshake timeout으로 에러 감지
- 재시도 가능

## 🎉 완료!

이제 Flutter 앱과 React WebView가 안전하게 통신하는 샘플이 완성되었습니다!

### 다음 단계

1. **프로덕션 배포**

   - React 앱 빌드: `pnpm build`
   - 빌드된 파일을 웹 서버에 배포
   - Flutter에서 배포된 URL 사용

2. **추가 기능 구현**

   - 새로운 액션 타입 추가
   - 에러 핸들링 강화
   - 로딩 상태 개선

3. **보안 강화**
   - Message validation
   - Origin checking
   - Permission management
