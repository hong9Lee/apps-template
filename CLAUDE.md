# Apps Template - Project Context

## 목적

광고 수익 기반 인디 앱을 **빠르고 대량으로** 생산하기 위한 Flutter 템플릿 프로젝트.
고퀄리티가 아닌 **생산성**에 포커스. clone → feature 추가 → Play Store 출시의 반복 워크플로우.

## 앱 선정 전략 — "틈새 공략"

과열된 앱 시장에서 후발주자가 살아남는 방법:

### 1단계: 검색 상위 카테고리 분석
- Play Store에서 사람들이 **실제로 검색하는 키워드** 상위 20개를 뽑는다
- 예: calculator, sound meter, QR code, timer, background remover 등

### 2단계: 기존 선점 앱의 불만 파악
- 상위 앱들의 **낮은 별점(★1~2) 리뷰를 집중 분석**한다
- 공통 불만 패턴을 찾는다:
  - "광고가 너무 많아서 못 쓰겠다"
  - "기능은 좋은데 UI가 구려"
  - "기본 기능인데 유료로 막아놨다"
  - "오프라인에서 안 된다"

### 3단계: 불만 = 우리의 차별점
- 기존 앱의 불만을 **그대로 우리 앱의 강점**으로 만든다
- 예시:
  - 기존 계산기: 광고 도배 → **CalcPack**: 계산 중 광고 제로, 홈에서만 배너
  - 기존 데시벨 앱: 측정 중 배너 → **DecibelByte**: 측정 화면 완전 클린
  - 기존 배경제거: 워터마크 강제 → **CutBG**: 리워드 1회로 워터마크 제거

### 4단계: 빠르게 출시, 반복
- 템플릿으로 공통 인프라(Firebase, AdMob, GDPR)는 0분에 해결
- 앱 고유 기능에만 집중 → 1~2일 내 출시 가능
- 10개, 20개, 50개... 양으로 수익 분산

### 핵심 원칙
- **광고는 사용자 경험을 해치지 않는 타이밍에만** (전환 순간, 자발적 리워드)
- **핵심 기능은 무료**, 부가 기능만 리워드로 해금
- **1회 리워드 → 영구 해금** (유저 친화적, 리텐션 ↑)
- 기존 앱보다 **UI가 깔끔하고 다크 테마**로 현대적 느낌

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

## 삽질 기록 & 해결 패턴

실제 앱 개발 중 겪은 문제와 해결법. 같은 실수를 반복하지 않기 위한 기록.

### 오디오 관련 (audioplayers 패키지 사용 시)

#### 1. `just_audio` (ExoPlayer) → OOM 크래시
- **문제**: `just_audio`는 ExoPlayer 기반. 여러 AudioPlayer 인스턴스 생성 시 OutOfMemoryError 발생
- **해결**: `audioplayers` 패키지 사용 (MediaPlayer 기반, 훨씬 가벼움)

#### 2. `audioplayers` ReleaseMode.loop → 루프 사이 ~0.5초 갭
- **문제**: `audioplayers`의 루프 모드는 **공식 인정된 갭 이슈** ([Issue #77](https://github.com/bluefireteam/audioplayers/issues/77))
- **해결**: 듀얼 플레이어 교대 방식
  - 사운드 1개당 AudioPlayer 2개 (A, B) 생성
  - Player A가 끝나기 2초 전에 Player B 시작
  - WAV 파일에 2초 크로스페이드 내장 (시작: fade-in, 끝: fade-out)
  - 두 플레이어가 겹치는 동안 자연스럽게 이어짐
  - `ReleaseMode.stop` 사용 (loop 아님)

#### 3. 동시 재생 시 소리가 안 남
- **문제**: `audioplayers`의 기본 AudioFocus가 새 플레이어 시작 시 이전 플레이어를 자동 일시정지
- **해결**: `AndroidAudioFocus.none` + `AVAudioSessionOptions.mixWithOthers` 설정
  ```dart
  await player.setAudioContext(AudioContext(
    android: AudioContextAndroid(audioFocus: AndroidAudioFocus.none),
    iOS: AudioContextIOS(
      category: AVAudioSessionCategory.playback,
      options: {AVAudioSessionOptions.mixWithOthers},
    ),
  ));
  ```

#### 4. 프로시저럴 WAV 생성 시 캐시 무효화
- **문제**: 알고리즘 수정 후에도 이전 WAV 캐시가 계속 재생됨
- **해결**: 파일명에 버전 포함 (`dripnap_v{version}_{id}.wav`), 알고리즘 변경 시 버전 증가

### 광고 관련

#### 5. 전체화면 광고 중 앱 소리가 계속 남
- **문제**: 전면/리워드/App Open 광고가 뜰 때 앱의 오디오가 배경에서 계속 재생
- **해결**: 모든 전체화면 광고 매니저에 mute/unmute 콜백 추가
  ```dart
  _ad!.fullScreenContentCallback = FullScreenContentCallback(
    onAdShowedFullScreenContent: (_) => AudioService.muteAll(),
    onAdDismissedFullScreenContent: (ad) {
      AudioService.unmuteAll();
      ad.dispose();
      // ...
    },
  );
  ```

#### 6. 전면 광고가 너무 자주 노출 → 사용성 파괴
- **문제**: `interstitial_interval: 3`이면 3번째 액션마다 광고 → "뭐 하나 누르면 광고만 뜸"
- **해결**: `interstitial_interval: 5` 이상 권장. 정지(stop) 액션은 카운트에서 제외. Remote Config로 서버에서 조절 가능

#### 7. 리워드 광고 활용 전략
- **리워드 광고 eCPM이 전면 광고의 2-5배** (~$5-15 vs ~$1-3)
- 사용자 자발적 시청이라 정책 리스크 낮음
- 추천 패턴: N번째 액션마다 리워드 광고 표시 (예: 3번째 사운드 선택 시)

### UI/UX 관련

#### 8. 활성 상태 표시는 아이콘으로
- **문제**: "Tap to play/stop" 같은 텍스트 힌트는 사용자가 싫어함
- **해결**: play/pause 아이콘 오버레이 (우하단 작은 원형) + 활성 시 glow 효과 + pulse 애니메이션

#### 9. SnackBar 중복 노출
- **문제**: 같은 경고가 연속으로 쌓여서 오래 남음
- **해결**: `ScaffoldMessenger.of(context).clearSnackBars()` 호출 후 새 SnackBar 표시

---

## Tintopia (컬러링 북) 교훈

### CustomPaint / Canvas 관련

#### 10. Hit test는 "가장 작은 영역" 기준으로
- **문제**: `Path.contains(point)`로 영역 클릭 감지 시, 큰 영역(배경)이 작은 영역(잎사귀 안쪽)보다 먼저 매칭되어 의도한 영역이 선택 안 됨
- **해결**: 모든 영역을 순회하며 `getBounds()` 면적이 가장 작은 영역을 선택
  ```dart
  int? _hitTest(Offset pos) {
    int? bestIndex;
    double bestArea = double.infinity;
    for (var i = 0; i < regions.length; i++) {
      if (regions[i].path.contains(pos)) {
        final bounds = regions[i].path.getBounds();
        final area = bounds.width * bounds.height;
        if (area < bestArea) {
          bestArea = area;
          bestIndex = i;
        }
      }
    }
    return bestIndex;
  }
  ```

#### 11. 브러시 모드에서 영역 채우기 vs 시각적 스트로크
- **문제**: 브러시로 터치 시 영역 전체가 즉시 색으로 채워지면 사용자 경험이 나쁨 ("닿으면 바로 그 영역이 칠해져버려")
- **해결**: 브러시 모드는 영역 채우기(region fill) 제거, 순수 시각적 스트로크(반투명 페인트 선)만 그림
- **역할 분리**: Fill = 영역 단위 정확한 색 채우기, Brush = 자유롭게 칠하는 수채화 느낌
- **블렌딩**: 반투명(alpha 180) 스트로크가 레이어로 쌓이면서 자연스러운 색 혼합 효과

#### 12. shouldRepaint는 상황에 맞게
- 인터랙티브 캔버스(색칠, 드로잉): `shouldRepaint() => true` (매 프레임 갱신 필요)
- 정적 썸네일/아웃라인: `shouldRepaint() => oldDelegate.id != id` (데이터 변경 시만)

### 로컬 저장 / CRUD 관련

#### 13. 화면 간 데이터 동기화 — Navigator.push 복귀 후 reload
- **문제**: 상세 화면에서 이름 변경 후 목록으로 돌아오면 이전 이름이 그대로 표시됨
- **해결**: `await Navigator.push(...)` 후 반드시 데이터 리로드
  ```dart
  void _openItem(Item item) async {
    await Navigator.push(context, MaterialPageRoute(...));
    await _loadItems();  // 복귀 후 최신 데이터 로드
  }
  ```

#### 14. 슬롯 시스템으로 무료/유료 리소스 관리
- **패턴**: 무료 N개 + 리워드 광고 시청 시 M개 추가
- **구현**: `SharedPreferences`에 보너스 슬롯 수 저장, `totalSlots = freeSlots + bonusSlots`
- **UX**: 슬롯 부족 시 다이얼로그 → "Watch Ad" 버튼 → 리워드 광고 → 슬롯 해제
- 유저 데이터 저장은 `path_provider` + JSON 파일로 충분 (DB 불필요, 비용 0)

#### 15. Long press는 발견성이 낮음 — 명시적 UI 추가
- **문제**: 카드 long press로 메뉴(이름 변경/삭제) 제공했으나 사용자가 인지 못함
- **해결**: 카드에 `⋮` (more_vert) 아이콘 버튼 추가 → 탭으로도 메뉴 접근 가능
- **원칙**: 중요한 기능은 항상 시각적 어포던스가 있어야 함

### 광고 정책 추가 교훈

#### 16. 광고 타이밍은 "전환 순간"에만
- **문제**: 색칠 중 매번 색 선택할 때마다 전면 광고 → 사용성 극악 ("광고가 너무 자주떠서 사용성이 극악이야")
- **해결**: **몰입 활동 중에는 광고 절대 금지**, 화면 전환(갤러리 복귀) 시에만 전면 광고
- **원칙**: 사용자가 "한 작업을 완료하고 다음으로 넘어가는 순간"에만 전면 광고 허용
  - ✅ 갤러리로 복귀, 화면 전환
  - ❌ 색 선택, 도구 변경, 칠하기 등 진행 중 액션

#### 17. 프로시저럴 콘텐츠 생성은 저작권 안전
- 수학/알고리즘으로 생성된 패턴(만다라, 기하학, 모자이크 등)은 저작권 문제 없음
- 외부 이미지 에셋 불필요 → 앱 크기 최소화, 법적 리스크 제로
- 시드(seed) 기반 생성으로 무한한 다양성 확보 가능

## ⚠️ Git 워크플로우 — 반드시 지켜야 할 규칙

### 템플릿 레포 (apps-template) 보호 규칙

1. **이 레포에는 템플릿 공통 기능만 커밋한다.** 앱별 고유 코드(SpickaRoo, CalcPack 등)는 절대 이 레포에 커밋하지 않는다.
2. **앱별 파일(아이콘, 프라이버시 정책, 앱 고유 기능)은 각 앱 레포에만 존재해야 한다.**

### 새 앱 생성 시 Git 워크플로우

```bash
# 1. 템플릿 복사 (git clone이 아닌 파일 복사)
cp -r apps_template /path/to/app_list/NewApp

# 2. 기존 .git 삭제 (템플릿 히스토리 제거 — 필수!)
cd /path/to/app_list/NewApp
rm -rf .git

# 3. 새 git 초기화
git init
git remote add origin https://github.com/hong9Lee/NewApp.git

# 4. 앱 고유 기능 개발 후 커밋
git add -A
git commit -m "Initial NewApp - ..."
git branch -M main
git push -u origin main
```

### 절대 하지 말 것

- ❌ 템플릿 디렉토리에서 직접 `git add` / `git commit` / `git push` (앱 코드가 템플릿에 들어감)
- ❌ 템플릿을 `.git`째로 복사한 후 그대로 push (템플릿 커밋 히스토리 23개가 앱 레포에 포함됨)
- ❌ 앱 레포에서 작업 중 cwd가 템플릿으로 바뀐 상태에서 commit (워크트리 환경에서 특히 주의)

### 올바른 앱 레포 상태

각 앱 레포에는 아래처럼 **앱 고유 커밋만** 존재해야 한다:
```
abc1234 Fix some bug
def5678 Initial AppName - description of app
```
템플릿 히스토리(init, Add Firebase, Add AdMob 등)가 보이면 안 된다.

### 디렉토리 구조 참고

```
apps/
├── apps_template/          ← 이 레포 (템플릿 전용, 앱 코드 금지)
└── app_list/
    ├── SpickaRoo/          ← 독립 git 레포
    ├── CalcPack/           ← 독립 git 레포
    ├── DecibelByte/        ← 독립 git 레포
    └── ...
```
