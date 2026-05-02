# Findew

> 병원 환자 실내 위치 추적 시스템의 iOS 클라이언트 — Apple Developer Academy @ POSTECH 6기 챌린지 프로젝트.

ESP32-C6 비콘으로부터 수집된 위치 데이터를 의료진/관리자가 실시간으로 확인할 수 있는 SwiftUI 기반 iOS 앱.

## 🧩 프로젝트 구성 (FindU 생태계)

| 컴포넌트 | 역할 | 레포 |
|---------|------|------|
| **Findew (이 레포)** | iOS 클라이언트 — 환자/디바이스/실내맵 모니터링 | `ADA6-IoT/SwiftUIApp` |
| ESP32-C6 펌웨어 | FTM/ESP-NOW 기반 위치 비콘·게이트웨이 | `ADA6-IoT/SwiftEmbedded` |
| Vapor 백엔드 | REST API + JWT 인증 + PostgreSQL + S3 | `ADA6-IoT/VaporServer` |

## 📱 주요 기능

- **로그인 인증** — JWT 토큰 + 자동 갱신 (TokenRefresh)
- **환자 관리 탭** — 환자별 현재 위치/상태 모니터링
- **디바이스 관리 탭** — 비콘/게이트웨이 디바이스 등록·관리
- **실내 지도(IndoorMap)** — Apple **IMDF** (Indoor Mapping Data Format) 기반 시각화
- **부서/병실 관리** — 병원 행정 단위 매핑

## 🛠 기술 스택

- **Language / UI**: Swift, SwiftUI
- **Min iOS**: 26.0
- **Architecture**: AppFlow + DIContainer (의존성 주입), Clean Architecture (Network: UseCase → Service → Router)
- **Auth**: JWT + Keychain 저장 + 토큰 자동 갱신
- **Map**: IMDF (Apple Indoor Maps)
- **Networking**: URLSession + Router 패턴

## 🚀 실행 방법

### 사전 요구사항
- macOS + Xcode 26 이상
- iOS 26.0 시뮬레이터 또는 실기기
- 백엔드(`VaporServer`) 실행 중

### 빌드 & 실행
```bash
git clone https://github.com/ADA6-IoT/SwiftUIApp.git
cd SwiftUIApp/Findew
open Findew.xcodeproj
```

Xcode에서:
1. `Findew` scheme 선택
2. 시뮬레이터/디바이스 선택
3. ⌘R 빌드+실행

### 서버 URL 설정
`Findew/Core/Secret/` 또는 `Findew/Resources/Environment/`에 환경 설정 (백엔드 주소).

## 🗂 프로젝트 구조

```
Findew/Findew/
├── App/                  # @main FindewApp + AppDelegate
├── Common/               # 공용 컴포넌트
├── Core/
│   └── Secret/           # API 키/시크릿
├── Model/
│   ├── DTO/              # 네트워크 응답 모델
│   ├── Domain/           # 비즈니스 도메인 모델
│   └── IMDF/             # Indoor Mapping Data Format
├── Network/
│   ├── Common/           # 공통 응답 처리
│   ├── Protocol/         # 네트워크 프로토콜
│   ├── Router/           # Auth/Department/Device/Hospital/Patient/Room
│   ├── Service/          # 도메인별 서비스
│   ├── TokenRefresh/     # JWT 토큰 갱신
│   └── UseCase/          # 유스케이스 레이어
├── Present/
│   ├── AppFlow/          # 앱 상태 머신 (splash/login/home)
│   └── Tab/              # FindUTab + Devices/IndoorMap/Patients/ToolBar
└── Resources/
    ├── Assets/, Fonts/, Static/
    ├── Extension/, Modifier/
    ├── Keychain/         # Keychain 래퍼
    └── Environment/      # 환경 변수
```

## 🔖 브랜치 컨벤션
* `main` - 제품 출시 브랜치
* `develop` - 출시를 위해 개발하는 브랜치
* `feat/xx` - 기능 단위로 독립적인 개발 환경을 위해 작성
* `refac/xx` - 개발된 기능을 리팩토링 하기 위해 작성
* `hotfix/xx` - 출시 버전에서 발생한 버그를 수정하는 브랜치
* `chore/xx` - 빌드 작업, 패키지 매니저 설정 등
* `design/xx` - 디자인 변경
* `bugfix/xx` - 버그 수정

## 🌀 코딩 컨벤션

* 파라미터 이름을 기준으로 줄바꿈 한다.
```swift
let actionSheet = UIActionSheet(
  title: "정말 계정을 삭제하실 건가요?",
  delegate: self,
  cancelButtonTitle: "취소",
  destructiveButtonTitle: "삭제해주세요"
)
```

* `if let` 구문이 길 경우 줄바꿈 한다.
```swift
if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
   let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
   user.gender == .female {
  // ...
}
```

* 추가 작업 부분: `// TODO: - xxx`
* 코드 섹션 분리: `// MARK: - xxx`
* 함수에는 액션을 알 수 있는 주석 작성

## 📁 PR 컨벤션

PR 시 템플릿이 등장한다. 작성 항목:
1. **PR 유형 작성** — `[]` 사이에 `x` 입력하여 체크
2. **작업 내용 작성** — 자세하게
3. **추후 진행할 작업** — PR 이후 작업 내용
4. **리뷰 포인트** — 본인 PR에서 확인이 꼭 필요한 부분

## 📑 커밋 컨벤션

### 🏷️ 태그
| 태그 | 설명 |
|------|------|
| `[Feat]` | 새로운 기능 추가 |
| `[Fix]` | 버그 수정 |
| `[Refactor]` | 코드 리팩토링 (기능 변경 없이 구조 개선) |
| `[Style]` | 코드 포맷팅, 들여쓰기 수정 등 |
| `[Docs]` | README, 문서 수정 |
| `[Test]` | 테스트 코드 추가 및 수정 |
| `[Chore]` | 패키지 매니저, 빌드 설정 등 |
| `[Design]` | UI, 레이아웃 등 디자인 관련 수정 |
| `[Hotfix]` | 운영 중 긴급 수정 |
| `[CI/CD]` | 배포·워크플로우 관련 |

### 💬 깃모지 (자주 쓰는 것 위주)

| 아이콘 | 용도 | | 아이콘 | 용도 |
|:---:|---|:---:|:---:|---|
| 🎉 | 프로젝트 시작 | | 📝 | 문서 추가/수정 |
| ✨ | 새 기능 | | 🐛 | 버그 수정 |
| 💄 | UI/스타일 | | ♻️ | 리팩토링 |
| 🔧 | 설정 변경 | | 🚑 | 긴급 수정 |
| 🔥 | 코드/파일 삭제 | | ⚡️ | 성능 개선 |
| ➕ | 의존성 추가 | | 🙈 | .gitignore |

### ✅ 예시
> 🎉 [Chore] 프로젝트 초기 세팅
> ✨ [Feat] 환자 위치 추적 화면 구현
> 🐛 [Fix] 토큰 갱신 시 무한 루프 수정
> 💄 [Design] 로그인 화면 레이아웃 조정
> 📝 [Docs] README 환경 설정 섹션 추가

## 👥 팀

ADA6-IoT — Apple Developer Academy @ POSTECH 6기

## 📄 라이선스

MIT License — 자세한 내용은 [LICENSE](./LICENSE) 참고.
