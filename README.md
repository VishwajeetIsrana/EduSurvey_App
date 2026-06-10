# EduSurvey

A Flutter-based mobile application for conducting educational surveys and collecting feedback from students.

## Features

- **User Authentication** — Register and login with phone number and password
- **Survey Questionnaires** — Browse and complete education-themed surveys
- **Location Tracking** — Captures GPS coordinates upon survey submission
- **Submission History** — View past submissions with detailed answers and location
- **User Profile** — Manage profile picture, email, and phone number
- **Offline Storage** — All data persisted locally using Hive database

## Architecture

The app follows **MVC (Model-View-Controller)** pattern:

```
lib/
├── models/        # Data models (User, Submission, Questionnaire, Question)
├── view/          # UI screens (login, register, home, questionnaire, profile)
├── controllers/   # Business logic and state management (GetX)
├── services/      # Data access layer (local storage, mock API)
├── widgets/       # Reusable UI components (app bar, bottom nav)
├── app/           # App configuration (theme, routes)
└── utils/         # Utilities (snackbar helpers)
```

## Tech Stack

| Technology | Purpose |
|---|---|
| Flutter / Dart | Cross-platform UI framework |
| GetX | State management, routing, DI |
| Hive / Hive Flutter | Local NoSQL database |
| Geolocator | GPS location capture |
| Google Fonts | Custom typography (Inter) |
| Image Picker | Profile picture selection |
| UUID | Unique identifier generation |

## Setup

```bash
# Clone the repository
git clone https://github.com/yourusername/edusurvey.git
cd edusurvey

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build Release APK

```bash
flutter build apk --release
```

The release build includes ProGuard/R8 code shrinking, resource shrinking, and obfuscation for optimal app size.

## Usage

1. **Register** — Create an account with email, phone, and password
2. **Login** — Sign in with your phone number and password
3. **Browse Surveys** — View available education-themed questionnaires
4. **Submit** — Answer all questions and submit with GPS location
5. **Track** — View submission history and details in your profile

## Project Status

Complete — ready for deployment or further enhancement.
