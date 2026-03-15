# Apps Template - Project Context

## 목적

광고 수익 기반 인디 앱을 **빠르고 대량으로** 생산하기 위한 Flutter 템플릿 프로젝트.
고퀄리티가 아닌 **생산성**에 포커스. clone → feature 추가 → Play Store 출시의 반복 워크플로우.

## 워크플로우

```
1. 이 템플릿을 clone
2. 앱 고유 feature 추가
3. Play Store 출시
```

clone 시 변경이 필요한 항목은 아래 "Clone Checklist" 참고.

## 타겟 플랫폼

- **Android 우선** (Play Store 먼저 출시)
- **iOS 예정** (수익화 구조 검증 후 App Store 출시 계획 → Flutter 선택 이유)
- Web, Desktop은 사용하지 않음

## 타겟 사용자

- **전세계 대상** — 앱 UI는 **영어 기본**으로 작성
- `flutter_localizations` 포함 — Material 위젯(DatePicker, Dialog 버튼 등)은 기기 언어에 맞게 자동 번역
- 앱 고유 문자열은 영어로 하드코딩 (생산성 우선, ARB 기반 다국어 불필요)

## 기술 스택

- **Flutter** (Dart SDK ^3.11.1, Flutter >=3.18.0)
- **Android**: Gradle 8.14, AGP 8.11.1, Kotlin 2.2.20, Java 17
- **상태관리**: 앱별로 결정 (템플릿에서는 미지정)
- **패키지 레지스트리**: pub.dev

## 템플릿 기능 목록

### 필수 기능 (모두 구현 필요)

| # | 기능 | 패키지 | 용도 |
|---|------|--------|------|
| 1 | Firebase Analytics | `firebase_analytics` | 사용자 행동 추적, 화면 전환 로깅 |
| 2 | Crashlytics | `firebase_crashlytics` | 크래시 자동 수집 및 리포팅 |
| 3 | AdMob | `google_mobile_ads` | 광고 수익 (배너, 전면, 리워드, App Open) |
| 4 | In App Review | `in_app_review` | 스토어 별점 유도 |
| 5 | Remote Config | `firebase_remote_config` | 서버에서 값 변경 (광고 빈도, UI 텍스트 등) |
| 6 | GDPR/UMP 동의 | `google_mobile_ads` 내장 UMP | 개인정보 동의 화면 (AdMob 필수 요구사항) |
| 7 | App Open Ad | `google_mobile_ads` | 앱 실행/복귀 시 전면 광고 |
| 8 | Force Update | Remote Config 활용 | 최소 버전 강제 업데이트 다이얼로그 |
| 9 | App Lifecycle | Flutter 내장 `AppLifecycleListener` | 포그라운드 복귀 시 App Open Ad 등 처리 |
| 10 | 광고 ID 자동 분리 | `kDebugMode` | debug=테스트 광고, release=실제 광고 (flavor 불필요) |
| 11 | 난독화 | ProGuard/R8 | 릴리즈 빌드 코드 보호, Firebase/AdMob 규칙 포함 |
| 12 | Material 자동 번역 | `flutter_localizations` | Material 위젯이 기기 언어에 맞게 자동 번역 |

### 의도적으로 제외한 기능

- FCM 푸시 알림 (앱별로 필요 시 추가. 템플릿 공통 기능 아님)
- Firebase Performance Monitoring (불필요한 복잡도)
- Network Check / connectivity_plus (AdMob SDK가 오프라인 자체 처리)
- 로컬 저장소 라이브러리 (앱별로 필요 시 추가)
- 테스트 코드 (생산성 우선)
- CI/CD (수동 빌드 및 배포)

## 광고 정책 주의사항

### AdMob 정책 (위반 시 계정 정지)
- **debug 빌드에서는 자동으로 테스트 광고 ID 사용** → kDebugMode 기반 자동 분리
- **GDPR 동의(UMP) 없이 광고 표시 금지** → EEA 사용자 대상 필수
- 자체 클릭 유도 금지, 광고 위치 가이드라인 준수
- 앱 콘텐츠가 있어야 함 (광고만 있는 앱은 리젝)

### Play Store 정책
- 개인정보처리방침 URL 필수
- targetSdkVersion 최신 유지 (Google 연간 요구사항)
- 앱 콘텐츠 등급 설정 필수

## 프로젝트 구조 (목표)

```
lib/
├── main.dart                    # 앱 진입점 + MaterialApp
├── config/
│   ├── ad_config.dart           # AdMob 광고 ID 관리 (debug/release 자동 분리)
│   ├── remote_config.dart       # Remote Config 키 및 기본값
│   └── firebase_config.dart     # Firebase 초기화
├── core/
│   ├── admob/
│   │   ├── banner_ad_widget.dart
│   │   ├── interstitial_ad_manager.dart
│   │   ├── rewarded_ad_manager.dart
│   │   └── app_open_ad_manager.dart
│   ├── analytics_service.dart   # Firebase Analytics 래퍼
│   ├── consent_manager.dart     # GDPR/UMP 동의 처리
│   ├── force_update.dart        # 강제 업데이트 체크
│   └── review_service.dart      # In App Review 로직
├── features/                    # 앱별 고유 기능 (clone 후 여기에 추가)
│   └── .gitkeep
└── shared/                      # 공통 위젯, 유틸리티
    └── .gitkeep
```

## 클론 후 출시까지 필수 단계

템플릿을 clone한 후, 아래 순서대로 진행해야 빌드 및 출시가 가능하다.

### Step 1. 앱 식별자 변경
- [ ] `android/app/build.gradle.kts` → `applicationId` 변경 (예: `com.hg.myapp`)
- [ ] `android/app/build.gradle.kts` → `namespace` 변경
- [ ] `pubspec.yaml` → `name`, `description` 변경

### Step 2. Firebase 프로젝트 연결 (빌드 필수 — 없으면 빌드 실패)
- [ ] [Firebase Console](https://console.firebase.google.com/)에서 새 프로젝트 생성
- [ ] Android 앱 등록 (applicationId 입력)
- [ ] `google-services.json` 다운로드 → `android/app/` 에 배치
- [ ] Firebase Console에서 Analytics, Crashlytics, Remote Config 활성화

> **주의: `google-services.json` 없이는 빌드 자체가 불가능하다.**
> 템플릿에는 포함되어 있지 않으므로, clone 후 가장 먼저 해야 할 작업.

### Step 3. AdMob 설정
- [ ] [AdMob Console](https://admob.google.com/)에서 새 앱 등록
- [ ] 광고 유닛 생성 (배너, 전면, 리워드, App Open)
- [ ] `lib/config/ad_config.dart` → `_prod*` 상수에 실제 광고 유닛 ID 입력
- [ ] `AndroidManifest.xml` → `com.google.android.gms.ads.APPLICATION_ID` 값을 실제 AdMob App ID로 교체 (현재 테스트 ID)

> **주의: `ad_config.dart`의 prod ID가 placeholder(`XXXXXXXX`)이면 광고 수익 0원.**
> **`AndroidManifest.xml`의 AdMob App ID도 테스트 ID → 실제 ID로 반드시 교체.**

### Step 4. 앱 고유 기능 개발
- [ ] `lib/features/` 디렉토리에 앱 고유 기능 구현
- [ ] 앱 아이콘 교체
- [ ] 앱 이름 변경 (`build.gradle.kts`의 `resValue("string", "app_name", "...")`)

### Step 5. 출시 준비
- [ ] 개인정보처리방침 URL 준비 (Play Store 필수)
- [ ] 서명 키 생성 (`keytool`) 및 `key.properties` 설정
- [ ] `build.gradle.kts`에 release signingConfig 설정 (현재 debug 키 사용 중)
- [ ] Firebase Console에서 Remote Config 기본값 설정

### Step 6. 빌드 및 출시
- [ ] `flutter build appbundle --obfuscate --split-debug-info=build/debug-info`
- [ ] Play Console에 앱 등록 + AAB 업로드
- [ ] 앱 콘텐츠 등급 설정
- [ ] 스토어 등록정보 작성 (스크린샷, 설명 등)

## Remote Config 기본 키

| 키 | 타입 | 기본값 | 용도 |
|----|------|--------|------|
| `minimum_version` | String | `"1.0.0"` | 강제 업데이트 기준 버전 |
| `interstitial_interval` | int | `3` | 전면 광고 노출 간격 (액션 횟수) |
| `enable_app_open_ad` | bool | `true` | App Open Ad 활성화 여부 |
| `enable_rewarded_ad` | bool | `true` | 리워드 광고 활성화 여부 |
| `enable_banner_ad` | bool | `true` | 배너 광고 활성화 여부 |
| `review_prompt_count` | int | `5` | 리뷰 요청 시점 (앱 실행 횟수) |

## 빌드 명령어

```bash
# 개발 (자동으로 테스트 광고)
flutter run

# 릴리즈 빌드 (자동으로 실제 광고)
flutter build appbundle

# 난독화 포함 릴리즈
flutter build appbundle --obfuscate --split-debug-info=build/debug-info
```

## 코딩 컨벤션

- **간결함 우선**: 보일러플레이트 최소화, 빠른 구현
- **주석 최소화**: 코드가 자명하면 주석 불필요
- **에러 핸들링**: 크래시가 나면 Crashlytics가 잡음. 과도한 try-catch 불필요
- **테스트 없음**: 생산성 우선. 수동 테스트로 충분
- **feature 디렉토리**: 앱별 고유 기능은 `lib/features/`에 추가
