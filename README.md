# 📰 News App

<p align="center">
  <strong>Stay informed. Explore more. Read what matters.</strong><br>
  A modern Flutter news reader powered by <a href="https://newsapi.org/">NewsAPI</a>.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.12.2%2B-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.12.2%2B-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/License-TBD-lightgrey" alt="License">
  <img src="https://img.shields.io/badge/Platform-Flutter-54C5F8?logo=flutter&logoColor=white" alt="Platform">
</p>

## ✨ What is News App?

News App makes it easy to discover the latest headlines from different
categories and sources. Browse the news you care about, search for a story,
and enjoy a consistent reading experience in light or dark mode.

## 🚀 Features

| | Feature | Description |
|---|---|---|
| 🗂️ | **News categories** | General, Business, Sports, Technology, Entertainment, Health, and Science |
| 📰 | **Top headlines** | View the latest articles from each available source |
| 🔎 | **Article search** | Search for headlines within the selected category |
| 🌙 | **Theme switching** | Choose between light and dark themes |
| 🌍 | **Localization** | English and Arabic localization resources |
| 🎨 | **Adaptive branding** | Theme-aware logos, illustrations, and splash screen |
| ⚡ | **Cached images** | Faster loading for article thumbnails |
| 📱 | **Flutter UI** | One codebase for supported Flutter platforms |

## 🧭 How it works

```text
Open the app
    ↓
Choose a news category
    ↓
Select a source
    ↓
Read the latest headlines
    ↓
Search for a specific story
```

## 🛠️ Tech stack

- **Flutter & Dart** — cross-platform application development
- **Dio** — HTTP client for NewsAPI requests
- **Provider** — theme and locale state management
- **NewsAPI** — news sources and article data
- **cached_network_image** — network image caching
- **flutter_localizations & intl** — localization support

## 📋 Requirements

- Flutter SDK with Dart SDK `3.12.2` or newer
- A [NewsAPI account](https://newsapi.org/register) and API key
- An emulator, simulator, or physical device

Verify your Flutter installation:

```bash
flutter doctor
```

## ⚙️ Getting started

### 1. Clone the project

```bash
git clone https://github.com/MostafaMohy2/news_app.git
cd news_app
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Configure NewsAPI

Open `lib/api/api_manager.dart` and provide your NewsAPI credentials.

> 🔐 Never commit a real API key to a public repository. For production,
> use secure runtime configuration or a backend proxy.

### 4. Run the app

```bash
flutter run
```

List available devices with:

```bash
flutter devices
```

## 🧪 Development commands

```bash
# Check code quality
flutter analyze

# Run tests
flutter test

# Format Dart code
dart format .

# Build an Android APK
flutter build apk
```

## 🗂️ Project structure

```text
lib/
├── api/                 # NewsAPI client and network requests
├── core/
│   ├── config/          # Theme and locale state
│   ├── l10n/            # Generated localization classes
│   ├── models/          # Articles, sources, and categories
│   ├── theme/           # Light and dark themes
│   └── utils/           # Shared extensions and helpers
├── screens/
│   ├── home/            # Categories, feeds, search, and article UI
│   └── splash/          # Initial branding screen
└── main.dart            # App entry point and route setup
```

## 🧱 Architecture

- `ApiManager` handles requests to NewsAPI through `Dio`.
- Typed model classes parse API responses.
- `ChangeNotifier` and `Provider` manage app-wide theme and locale state.
- `MaterialApp` configures themes, localization delegates, and routes.
- Feature screens are grouped under `lib/screens/`.

## 🔌 API endpoints

The app currently uses:

| Endpoint | Purpose |
|---|---|
| `GET /v2/top-headlines/sources` | Load sources for a category |
| `GET /v2/top-headlines` | Load headlines for a source |
| `GET /v2/top-headlines?q=...` | Search headlines |

API availability and rate limits depend on your NewsAPI plan.

## 🌍 Localization status

Localization is configured through `l10n.yaml`, with English and Arabic
resources available. Some UI labels are still hard-coded, and Arabic language
switching in the settings control is not fully wired yet.

## 🖼️ Assets

Theme-aware logos, branding, and category illustrations are stored in:

```text
assets/images/
```

They are registered in `pubspec.yaml` and exposed through
`lib/core/utils/app_assets.dart`.

##🎥 Video Demo



https://github.com/user-attachments/assets/7d36f69e-e342-4033-a952-a27b51d3d8e3



---

## 📄 License

No license has been specified yet. Add a license before redistributing this
project or its source code.
