# App Test Plugin

A Flutter application built with modern architecture, featuring state management with Riverpod, navigation with GoRouter, and comprehensive logging.

## Features

- **State Management**: Uses Riverpod with Flutter Hooks for reactive state management.
- **Navigation**: Declarative routing with GoRouter.
- **Logging**: Integrated Talker for debugging and logging.
- **Multi-Platform**: Supports Android, iOS, Web, Windows, Linux, and macOS.
- **Theming**: Material 3 themes with light/dark mode support.

## Project Structure

```
lib/
├── app/
│   ├── app.dart          # Main app widget with themes and router
│   └── router/
│       ├── router.dart   # GoRouter configuration
│       └── routes.dart   # Route constants
├── core/
│   └── logger/           # Logging setup with Talker
├── features/
│   ├── home/             # Home feature (currently empty)
│   └── testing/          # Testing feature with root screen
└── shared/               # Shared utilities (currently empty)
```

## Getting Started

### Prerequisites

- Flutter SDK (^3.10.4)
- Dart SDK (^3.10.4)

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd app_test_plugin
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Building

- **Android**: `flutter build apk`
- **iOS**: `flutter build ios`
- **Web**: `flutter build web`
- **Desktop**: `flutter build <platform>`

## Architecture

This project follows a feature-based architecture with:
- **Presentation Layer**: Widgets and screens
- **Core Layer**: Shared services like logging
- **Features**: Modular feature implementations

## Dependencies

### Navigation
- `go_router`: Declarative routing

### State Management
- `hooks_riverpod`: Reactive state management
- `flutter_hooks`: Lifecycle hooks

### Logging
- `talker_flutter`: Flutter logging integration
- `talker_dio_logger`: HTTP logging
- `talker_riverpod_logger`: Riverpod state logging

## Development

### Running Tests
```bash
flutter test
```

### Code Analysis
```bash
flutter analyze
```

### Formatting
```bash
dart format .
```

## Contributing

1. Follow the existing code style
2. Add tests for new features
3. Update documentation as needed

## License

This project is private and not intended for publication.
