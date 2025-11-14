# Copilot Instructions for Stardust AAC

## Project Overview

Stardust AAC is an Augmentative and Alternative Communication iPad app built with Flutter/Dart. It enables photo-based communication with text-to-speech for individuals with speech challenges. Developed on Windows, final build on Mac. Target user: Milla (young child with autism).

## Architecture

- **Platform:** iOS (iPad), minimum iOS 12+, developed on Windows
- **Language:** Dart with Flutter framework
- **UI:** Flutter widgets (Cupertino for iOS look)
- **Storage:** Drift (SQLite) for structured data, path_provider for files
- **Audio:** record package for recording, flutter_tts for TTS, audioplayers for playback
- **State Management:** Provider or Riverpod
- **Data Flow:** Local-only, no cloud/network dependencies

### Key Components
- Photo management (image_picker package for camera/library)
- Label input (TextField with single-word validation)
- Audio recording (record package, 5-second limit, custom priority)
- TTS integration (flutter_tts with iOS system voices)
- Grid-based communication board (GridView.builder)
- Edit mode toggle (Provider state management)
- Tile preview system (Hero animation + overlay + Timer)

## Data Model

```dart
// Drift table definition
class Photos extends Table {
  TextColumn get id => text()();  // UUID
  TextColumn get imageFileName => text()();
  TextColumn get label => text()();
  TextColumn get customAudioFileName => text().nullable()();
  TextColumn get selectedVoiceId => text().nullable()();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get sortOrder => integer()();
  
  @override
  Set<Column> get primaryKey => {id};
}

// Settings (shared_preferences)
class AppSettings {
  final String defaultVoiceId;
  final double speechRate;        // 0.5 - 2.0
  final String tileSize;          // 'small', 'medium', 'large'
  final double autoCloseDuration; // 1.0, 2.0, 3.0, 5.0, 0 (manual)
  final bool useColorfulTiles;
}
```

Photos and audio files stored in app Documents directory (path_provider), referenced by filename in Drift database.

## Development Priorities

1. **Accessibility First** - Large touch targets (44pt minimum), VoiceOver support, Dynamic Type
2. **Offline Capable** - No internet dependency, all features work offline
3. **Privacy** - No analytics, no data collection, all data stays on device
4. **Simplicity** - Minimal cognitive load, direct interactions, no complex navigation
5. **Child-Friendly** - Large buttons, clear labels, immediate feedback

## Flutter-Specific Conventions

- Use Cupertino widgets for iOS-native look (CupertinoButton, CupertinoNavigationBar, etc.)
- Follow Apple Human Interface Guidelines for iPad design patterns
- State management with Provider or Riverpod (ChangeNotifier for simple state)
- Use `StatefulWidget` sparingly, prefer `StatelessWidget` + state management
- Drift database with StreamBuilder for reactive UI updates
- Handle permissions with permission_handler package
- Use async/await for all async operations (file I/O, database, audio)
- Organize code: lib/models/, lib/screens/, lib/widgets/, lib/services/

## Coding Standards

- Dart naming conventions (camelCase for variables, PascalCase for classes)
- Use async/await for all asynchronous operations (database, file I/O, audio)
- Comprehensive error handling with try-catch blocks
- Separate business logic from UI (use Provider/service classes)
- Follow effective Dart guidelines: https://dart.dev/guides/language/effective-dart
- Use const constructors where possible for performance
- Document complex logic with dartdoc comments
- Run `dart format` and `dart analyze` before committing

## Testing Approach

- Unit tests for data models and business logic
- UI tests for critical user flows (add photo, play audio)
- Manual testing focus: accessibility features, actual device testing (not just simulator)
- Test with real photos and audio to validate file storage

## Common Patterns

- **Photo Storage:** Use path_provider to get Documents directory, save with UUID filename, store reference in Drift
- **Audio Recording:** 5-second timer enforced with Timer widget, use record package with 22kHz mono AAC
- **Audio Priority:** Check file exists with File.exists(), play custom recording or fallback to TTS
- **TTS Playback:** flutter_tts package with await tts.speak(), configurable voice and speech rate
- **Grid Layout:** GridView.builder with crossAxisCount based on tileSize setting
- **Edit Mode:** Provider<EditModeState> with ChangeNotifier to toggle between modes
- **Tile Preview:** Stack with Positioned overlay, GestureDetector for tap, Timer for auto-dismiss
- **Settings Storage:** shared_preferences package with async get/set methods
- **Permissions:** permission_handler with await Permission.camera.request()
- **Navigation:** Navigator.push for screens, showDialog for modals

## Key Files (Future)

- `lib/models/photo.dart` - Drift table definition and data class
- `lib/models/app_settings.dart` - Settings data class with shared_preferences
- `lib/models/database.dart` - Drift database configuration
- `lib/providers/edit_mode_provider.dart` - Edit mode state management
- `lib/providers/photos_provider.dart` - Photos list state management
- `lib/screens/communication_board_screen.dart` - Main photo grid screen
- `lib/screens/settings_screen.dart` - Settings screen (Display, Voice, Behavior)
- `lib/widgets/tile_widget.dart` - Individual photo tile component
- `lib/widgets/tile_preview_overlay.dart` - Enlarged tile modal with auto-close
- `lib/screens/add_photo_flow/` - Multi-step photo addition screens
- `lib/services/audio_service.dart` - Recording, TTS, playback with priority logic
- `lib/services/storage_service.dart` - File operations (path_provider)
- `lib/services/database_service.dart` - Drift database operations wrapper

## Build & Run

**Development (Windows):**
```bash
# Install dependencies
flutter pub get

# Run on connected iPad
flutter run -d <device-id>

# Hot reload during development (press 'r' in terminal)
# Hot restart (press 'R' in terminal)

# Build for testing
flutter build ios --debug
```

**Production Build (Rick's Mac):**
```bash
flutter build ios --release
# Then open ios/Runner.xcworkspace in Xcode for signing and upload
```

## Important Constraints

- **5-second audio limit** - Enforced with Timer widget in recording UI
- **Single-word labels** - Guidance only (show hint, don't block)
- **iPad only** - Optimize for tablet sizes (no phone layouts initially)
- **No network** - Assume offline-first always, no internet dependencies
- **Windows development** - Must work without Mac for 95% of development
- **Mac for final build** - Rick's Mac only needed for App Store submission

## Accessibility Requirements

- All interactive elements must have Semantics widget with meaningful labels
- Support iOS Dynamic Type (use Text widget with default text scaling)
- High contrast mode compatibility (test with MediaQuery.highContrast)
- Use semantic labels: Semantics(label: 'description', child: widget)
- Photos should have alt text using image.semanticLabel
- Test with iOS VoiceOver on physical device
- Minimum touch targets: 44x44 logical pixels

## Questions for Developer Decisions

When implementing, decide on:
1. State management: Provider vs Riverpod (recommend Provider for simplicity)
2. Photo compression: image package with quality parameter (balance quality vs storage)
3. Audio format: AAC with record package (good size/quality balance)
4. Grid column count: 3 columns for iPad landscape, 2 for portrait
5. Voice selection UI: CupertinoActionSheet vs ListView (recommend ListView for preview)

## Future Considerations

- Categories/folders for organizing photos
- Phrase building (sequence of photos)
- iCloud backup option
- Multiple user profiles

---

**Remember:** This app is for Milla. Keep it simple, fast, and joyful to use. Every interaction should be delightful and empower communication.
