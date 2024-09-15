
# MyNovel Flutter App

A simple Flutter app to browse novels, search for titles, and view categories. This project is tested on Xiaomi 12T Pro with Android 12.

## Prerequisites

Before you begin, ensure you have met the following requirements:
- Flutter 3.24.3
- Dart 3.5.3
- DevTools 2.37.3
- An Android or iOS device/emulator for testing
- Android Studio or VS Code set up with Flutter plugin

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/your-username/mynovel-app.git
cd mynovel-app
```

### 2. Install Dependencies

Run the following command to install the required packages:

```bash
flutter pub get
```

### 3. Run the App

Connect your device/emulator and use the following command to run the app:

```bash
flutter run
```

### 4. Building for Release

To build the app for release:

```bash
flutter build apk
```

For iOS:

```bash
flutter build ios
```

## Testing Environment

- Tested on **Xiaomi 12T Pro** running Android 12.

## Assumptions

- The app assumes the user will enter at least 3 characters for the search functionality to work.
- Categories are displayed as swipable horizontally.
- The novel list supports pull-to-refresh to reload the content.

## Extra Information

- **Flutter Version**: 3.24.3
- **Dart Version**: 3.5.3
- **DevTools Version**: 2.37.3
