# Merl Cinema

A modern Flutter movie app with iOS support and GitHub Actions workflow for building IPA files.

## Features

- 🎬 Browse popular, top-rated, and now-playing movies
- 🔍 Search movies by title
- 📱 Beautiful, modern UI with dark/light theme support
- 🏗️ Clean Architecture with BLoC pattern
- 📱 iOS support with proper configuration
- 🚀 GitHub Actions workflow for automated IPA builds
- 🎨 Material Design 3 with custom theming
- 📊 Movie details with ratings, cast, and more

## Screenshots

The app includes:
- Home screen with tabbed navigation (Now Playing, Popular, Top Rated)
- Movie details screen with comprehensive information
- Search functionality
- Favorites management (placeholder for future implementation)

## Getting Started

### Prerequisites

- Flutter SDK (3.16.0 or higher)
- Dart SDK (3.0.0 or higher)
- iOS development environment (for iOS builds)
- TMDB API key

### Installation

1. **Clone the repository**
   ```bash
   git clone <your-repo-url>
   cd merl_cinema
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure API Key**
   - Get your TMDB API key from [The Movie Database](https://www.themoviedb.org/settings/api)
   - Update `lib/core/constants/app_constants.dart`:
   ```dart
   static const String apiKey = 'YOUR_TMDB_API_KEY';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## iOS Setup

### Prerequisites for iOS Development

1. **Xcode** (latest version recommended)
2. **iOS Simulator** or physical iOS device
3. **Apple Developer Account** (for device testing and App Store distribution)

### iOS Configuration

The app is already configured for iOS with:
- Minimum iOS version: 12.0
- Proper Info.plist with required permissions
- App icons and launch screen
- Xcode project configuration

### Running on iOS

1. **Open iOS Simulator**
   ```bash
   open -a Simulator
   ```

2. **Run on iOS**
   ```bash
   flutter run -d ios
   ```

## GitHub Actions Workflow

The repository includes a comprehensive GitHub Actions workflow for building IPA files:

### Workflow Features

- **Automated builds** on push to main/develop branches
- **Two build options**:
  - `ios-build.yml`: Standard build with CocoaPods fallback
  - `ios-build-simple.yml`: Simplified build without CocoaPods
- **iOS app building** (release, unsigned)
- **IPA generation** for testing and development
- **Artifact upload** for easy distribution

### Setup for Automated Builds

1. **No certificates required** - builds are unsigned
2. **Workflow Triggers**
    - The workflow runs automatically on pushes to `main` and `develop` branches
    - Manual triggers are also available via GitHub Actions UI

### Building IPA Files

The workflow creates **unsigned builds**:

1. **Unsigned Build** (for testing and development)
    - Runs on all branches
    - Creates unsigned IPA files
    - Good for internal testing and development
    - Can be installed on jailbroken devices or via third-party tools

## Project Structure

```
lib/
├── core/
│   ├── constants/          # App constants and configuration
│   ├── theme/             # App theming and colors
│   └── router/            # Navigation configuration
├── features/
│   └── movies/
│       ├── data/          # Data layer (models, datasources, repositories)
│       ├── domain/        # Domain layer (entities, use cases, repositories)
│       └── presentation/  # Presentation layer (pages, widgets, bloc)
└── main.dart              # App entry point
```

## Architecture

The app follows **Clean Architecture** principles:

- **Presentation Layer**: UI components, BLoC state management
- **Domain Layer**: Business logic, entities, use cases
- **Data Layer**: API calls, local storage, data models

### State Management

- **BLoC Pattern** for state management
- **Equatable** for value equality
- **Event-driven** architecture

## Dependencies

### Core Dependencies
- `flutter_bloc` - State management
- `dio` - HTTP client
- `go_router` - Navigation
- `cached_network_image` - Image caching
- `json_annotation` - JSON serialization

### Development Dependencies
- `build_runner` - Code generation
- `json_serializable` - JSON serialization
- `flutter_lints` - Code linting

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions:
- Create an issue in the repository
- Check the Flutter documentation
- Review the TMDB API documentation

## Acknowledgments

- [The Movie Database (TMDB)](https://www.themoviedb.org/) for the API
- Flutter team for the amazing framework
- The open-source community for various packages used


