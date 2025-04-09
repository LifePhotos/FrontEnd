# 📸 LifePhotos - 나만의 인생네컷 앨범

Flutter + FastAPI 기반으로 개발한 나만의 인생네컷 사진 앨범 앱입니다.  
사진을 업로드하고, 종이 넘기기 효과로 추억을 간직하세요.

## 🌟 주요 기능

- 사용자 로그인 및 회원가입
- 인생네컷 이미지 업로드
- 업로드한 이미지 앨범 뷰 (종이 넘기기 효과)
- 이미지 목록 메인 화면
- Flutter Provider로 API 통신 상태 관리

## 🎨 프론트엔드 기술 스택

<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" width="50" height="50" title="Flutter"/><br>
<img src="https://img.shields.io/badge/Provider-027DFD?style=for-the-badge&logo=flutter&logoColor=white" title="Provider"/><br>
<img src="https://img.shields.io/badge/Image%20Picker-34A853?style=for-the-badge&logo=google&logoColor=white" title="Image Picker"/><br>
<img src="https://img.shields.io/badge/PageView_UI-%23FF69B4?style=for-the-badge&logo=flutter&logoColor=white" title="PageView (종이 넘기기 UI)"/>


## ☘️ 백엔드 기술 스택

<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/spring/spring-original.svg" width="50" height="50" title="Spring Boot"/><br>
<img src="https://img.shields.io/badge/Spring_Security-6DB33F?style=for-the-badge&logo=springsecurity&logoColor=white" title="Spring Security"/><br>
<img src="https://img.shields.io/badge/Spring%20JPA-6DB33F?style=for-the-badge&logo=spring&logoColor=white" title="Spring JPA"/><br>
<img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/java/java-original.svg" width="50" height="50" title="Java"/>

## 🖼️ 앱 시연 화면

| 로그인 | 회원가입 | 메인화면 |
|--------|-----------|----------------|
| ![login](https://github.com/user-attachments/assets/4c8f5c85-28ef-4ca1-88e9-383fa0525bc8) | ![main](https://github.com/user-attachments/assets/567b811d-7ce5-4b56-be2a-ac72fffaad0e) | ![upload](https://github.com/user-attachments/assets/be6856c2-b3fd-4d25-891f-ddfad17aa6bf) |


## 📦 프로젝트 구조

```
📁 frontend (Flutter)
└── lib/
    ├── screens/        # 각 화면 UI 구성
    ├── widgets/        # 재사용 가능한 위젯
    └── services/       # API 통신 등 서비스 로직

📁 backend (FastAPI)
└── app/
    ├── routes/         # 라우팅 처리
    ├── models/         # DB 모델
    ├── schemas/        # Pydantic 스키마
    └── services/       # 비즈니스 로직
```


    
