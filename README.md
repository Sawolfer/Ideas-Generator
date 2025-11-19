# Bored Ideas Generator

A modern Flutter application that helps you discover exciting activities when you're bored. Swipe through ideas, save favorites, and never run out of things to do!

##  Features

- **Tinder-style Card Swiping** — Intuitive swipe interface for browsing activities
- **Favorites System** — Save interesting ideas for later with persistent storage
- **Real-time API Integration** — Fetches fresh activity suggestions from REST API
- **Offline Support** — Fallback activities ensure the app works even without internet
- **Beautiful UI** — Gradient cards with smooth animations and Material 3 design
- **State Management** — Clean architecture using Provider pattern

## Tech Stack

- **Framework:** Flutter 3.x
- **Language:** Dart
- **State Management:** Provider
- **Networking:** HTTP package
- **Local Storage:** SharedPreferences
- **UI Components:** 
  - flutter_card_swiper (Tinder-style cards)
  - Material 3 Design System

## Project Structure

```
lib/
├── ActivityProvider.dart
├── components
│   └── ActivityCard.dart
├── main.dart
├── model
│   └── ActivityModel.dart
└── screens
    ├── FavoriteScreen.dart
    └── HomeScreen.dart
```

## Installation

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- iOS Simulator / Android Emulator / Chrome browser

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Sawolfer/Ideas-Generator.git
   cd Ideas-Generator/ideas-generator

Install dependencies

```bash
flutter pub get
```

Run the app

```bash
# On iOS or Android emulator
flutter run

# On Chrome browser
flutter run -d chrome
```
