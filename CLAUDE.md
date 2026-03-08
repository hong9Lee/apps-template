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

- **Android only** (Play Store 출시 목적)
- iOS, Web, Desktop 코드는 Flutter 기본 생성물. 사용하지 않음.

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
| 8 | FCM 푸시 알림 | `firebase_messaging` | 리텐션 유지, 사용자 재방문 유도 |
| 9 | Network Check | `connectivity_plus` | 오프라인 시 광고 로드 방지 |
| 10 | Force Update | Remote Config 활용 | 최소 버전 강제 업데이트 다이얼로그 |
| 11 | App Lifecycle | Flutter 내장 `AppLifecycleListener` | 포그라운드 복귀 시 App Open Ad 등 처리 |
| 12 | Flavor 분리 | Flutter flavor + dart-define | dev(테스트 광고)/prod(실제 광고) 환경 분리 |
| 13 | 난독화 | ProGuard/R8 | 릴리즈 빌드 코드 보호, Firebase/AdMob 규칙 포함 |

### 의도적으로 제외한 기능

- Firebase Performance Monitoring (불필요한 복잡도)
- 로컬 저장소 라이브러리 (앱별로 필요 시 추가)
- iOS 관련 설정 전체
- 테스트 코드 (생산성 우선)
- CI/CD (수동 빌드 및 배포)

## 광고 정책 주의사항

### AdMob 정책 (위반 시 계정 정지)
- **dev 환경에서는 반드시 테스트 광고 ID 사용** → 실제 ID 사용 시 정책 위반
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
├── main.dart                    # 앱 진입점
├── app.dart                     # MaterialApp 설정, 라우팅
├── config/
│   ├── ad_config.dart           # AdMob 광고 ID 관리 (flavor별)
│   ├── remote_config.dart       # Remote Config 키 및 기본값
│   └── firebase_config.dart     # Firebase 초기화
├── core/
│   ├── admob/
│   │   ├── ad_manager.dart      # 광고 로드/표시 통합 관리
│   │   ├── banner_ad_widget.dart
│   │   ├── interstitial_ad_manager.dart
│   │   ├── rewarded_ad_manager.dart
│   │   └── app_open_ad_manager.dart
│   ├── analytics/
│   │   └── analytics_service.dart
│   ├── consent/
│   │   └── consent_manager.dart  # GDPR/UMP 동의 처리
│   ├── fcm/
│   │   └── fcm_service.dart      # 푸시 알림 설정
│   ├── network/
│   │   └── network_checker.dart  # 연결 상태 확인
│   ├── review/
│   │   └── review_service.dart   # In App Review 로직
│   └── update/
│       └── force_update.dart     # 강제 업데이트 체크
├── features/                     # 앱별 고유 기능 (clone 후 여기에 추가)
│   └── .gitkeep
└── shared/                       # 공통 위젯, 유틸리티
    └── .gitkeep
```

## Clone Checklist

템플릿을 clone한 후 반드시 변경해야 할 항목:

### 1. 앱 식별자
- [ ] `android/app/build.gradle.kts` → `applicationId` 변경 (예: `com.hg.myapp`)
- [ ] `android/app/build.gradle.kts` → `namespace` 변경
- [ ] `android/app/src/main/AndroidManifest.xml` → `android:label` 변경
- [ ] `pubspec.yaml` → `name`, `description` 변경

### 2. Firebase 프로젝트
- [ ] Firebase Console에서 새 프로젝트 생성
- [ ] `google-services.json` 교체 (android/app/)
- [ ] Analytics, Crashlytics, Remote Config, FCM 활성화

### 3. AdMob
- [ ] AdMob Console에서 새 앱 등록
- [ ] `ad_config.dart`에 실제 광고 유닛 ID 입력 (prod flavor)
- [ ] `AndroidManifest.xml`에 AdMob App ID 메타데이터 추가

### 4. 앱 고유 설정
- [ ] 앱 아이콘 교체
- [ ] 스플래시 화면 (선택)
- [ ] `features/` 디렉토리에 앱 고유 기능 구현
- [ ] 개인정보처리방침 URL 준비

### 5. 릴리즈 빌드
- [ ] 서명 키 생성 및 `key.properties` 설정
- [ ] `build.gradle.kts`에 release signingConfig 설정
- [ ] `flutter build appbundle --flavor prod` 로 빌드

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
# 개발 (테스트 광고)
flutter run --flavor dev --dart-define=FLAVOR=dev

# 릴리즈 빌드 (실제 광고)
flutter build appbundle --flavor prod --dart-define=FLAVOR=prod

# 난독화 포함 릴리즈
flutter build appbundle --flavor prod --dart-define=FLAVOR=prod --obfuscate --split-debug-info=build/debug-info
```

## 코딩 컨벤션

- **간결함 우선**: 보일러플레이트 최소화, 빠른 구현
- **주석 최소화**: 코드가 자명하면 주석 불필요
- **에러 핸들링**: 크래시가 나면 Crashlytics가 잡음. 과도한 try-catch 불필요
- **테스트 없음**: 생산성 우선. 수동 테스트로 충분
- **feature 디렉토리**: 앱별 고유 기능은 `lib/features/`에 추가
