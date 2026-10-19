# Serenity Space

A Flutter mobile app for everyday mental wellness: journaling, breathing exercises, relaxing sounds, sleep tracking, yoga and daily quotes in one calm place.

## Features

- **Account and profile:** register and log in, with user details stored locally in SQLite.
- **Journal:** write, save and review private journal entries (SQLite), with a confirmation notification when an entry is saved.
- **Breathing exercises:** guided breathing to help slow down and reset.
- **Relaxing sounds:** play calming audio tracks bundled with the app.
- **Relaxing images:** browse nature and relaxation photos loaded from the Unsplash API.
- **Sleep tracker:** start and stop a timer to record how long you slept.
- **Yoga:** browse yoga categories and poses loaded from a public yoga API.
- **Daily quotes:** a random motivational quote from the ZenQuotes API.
- **Mood foods:** a gallery of foods linked to calm and wellbeing, each with a short description.
- **About us:** contact information with tap-to-call and a map of the location.

## Tech stack

| Area | Tools |
|---|---|
| Framework | Flutter, Dart |
| Local storage | sqflite (SQLite) |
| Networking | http (Unsplash, ZenQuotes and yoga APIs) |
| Notifications | awesome_notifications |
| Audio | audioplayers |
| Maps and location | flutter_map, latlong2, geolocator, geocoding |
| Device actions | url_launcher, flutter_phone_direct_caller |

## Project structure

```text
lib/
├── main.dart                 # App entry point
├── SplashScreen.dart         # Launch screen
├── registerPage.dart         # Sign-up and login
├── homePage.dart, menuPage.dart
├── journalPage.dart, view_entries_page.dart, database_helper.dart
├── breathingTechnique.dart
├── relaxingPage.dart, relaxingSoundsPage.dart, relaxingImages.dart
├── sleepTrackerPage.dart
├── yogaPage.dart, quotesPage.dart, foodPage.dart
└── aboutUs.dart              # Contact info and map
assets/                       # Images and audio
```

## Running the app

1. Install [Flutter](https://docs.flutter.dev/get-started/install) and set up an Android emulator or a connected device.
2. Clone the repository and fetch the packages:

   ```bash
   git clone https://github.com/olajireolabode/Serenity-Space.git
   cd Serenity-Space
   flutter pub get
   ```

3. Run it:

   ```bash
   flutter run
   ```

## What I learned

- Structuring a multi-screen Flutter app with navigation between features
- Persisting user data on the device with SQLite
- Calling third-party REST APIs and handling loading and error states
- Working with device features: notifications, audio playback, phone calls and maps

## Future improvements

- Move API keys out of the source code into build-time configuration
- Secure password storage and a cloud backend for syncing entries
- Charts for sleep history and mood trends
- Widget and integration tests
