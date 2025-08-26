<div align="center">
  <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/flutter/flutter-original.svg" alt="Flutter" width="120"/>

  <h1>High Score Hazard - Flutter App</h1>
  <p>A funky card score tracker where scoring too high leads to fun forfeits!</p>

  <p>
    <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter" alt="Flutter">
    <img src="https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart" alt="Dart">
    <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-3DDC84.svg?style=for-the-badge&logo=android" alt="Platform">
  </p>
</div>

---

## ✨ Features

*   **🎯 Manual Scoring:** Easily add or subtract scores for each player during a round.
*   **📝 Custom Games:** Set a custom score threshold and a list of fun, user-defined tasks for the loser.
*   **👤 Player Profiles:** Save a roster of players to quickly start new games without re-typing names.
*   **🏆 Hall of Shame:** A persistent online leaderboard that tracks who has lost the most games over time.
*   **🎨 Game-like UI:** A retro, dark-themed design with a custom pixel font to make score tracking more fun.

## 🚀 Getting Started

Follow these steps to get the Flutter app running on your machine.

**1. Prerequisites**
Ensure you have the [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.

**2. Clone the repository**
```bash
git clone https://github.com/your-username/card_game.git
cd card_game
```

**3. Install dependencies**
```bash
flutter pub get
```

**4. Connect to the Backend**
This app requires a running instance of the [High Score Hazard Backend API](https://github.com/your-username/card_game_backend). You must update the API address to point to your server.

Open the file `lib/services/leaderboard_service.dart` and change the `_baseUrl` constant:
```dart
// For a local backend running on your computer:
// static const String _baseUrl = 'http://10.0.2.2:5001/leaderboard'; // For Android Emulator
// static const String _baseUrl = 'http://YOUR_WIFI_IP:5001/leaderboard'; // For iOS Simulator

// For the deployed Render backend:
static const String _baseUrl = 'https://your-app-name.onrender.com/leaderboard';
```

**5. Run the app**
```bash
flutter run
```

---

## 📦 Building for Production

To create a shareable file for Android:

**1. Build a Debug APK (for quick testing)**
```bash
flutter build apk
```
Find the file at `build/app/outputs/flutter-apk/app-debug.apk`.

**2. Build a Release App Bundle (for Google Play Store)**
_Ensure you have completed the [release signing setup](https://docs.flutter.dev/deployment/android#signing-the-app) first._
```bash
flutter build appbundle --release
```
Find the file at `build/app/outputs/bundle/release/app-release.aab`.
