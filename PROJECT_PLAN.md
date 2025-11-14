# Stardust AAC - Project Plan

## Project Overview

**Name:** Stardust AAC (Augmentative and Alternative Communication)  
**Target User:** Milla (and potentially other individuals with speech and language challenges)  
**Platform:** iPad (iOS tablets)  
**Purpose:** Enable communication through a photo-based system with text-to-speech capabilities

## Core Features

### 1. Photo Management
- **Photo Capture:** Use device camera to take new photos
- **Photo Upload:** Select existing photos from device photo library
- **Photo Storage:** Store photos locally within the app (no cloud dependency for privacy/offline use)

### 2. Photo Labeling
- **Single-word description:** Simple text input (one word per photo)
- **Clear, accessible input:** Large, easy-to-use keyboard interface
- **Edit capability:** Ability to update labels later

### 3. Audio Recording
- **Custom recording:** 5-second audio clip per photo (parent/caregiver voice)
- **Recording controls:** Simple start/stop/playback interface
- **Storage:** Store audio files locally with associated photo

### 4. Text-to-Speech (TTS)
- **AI Voice selection:** Choose from available iOS system voices
- **Voice preview:** Ability to hear voices before selection
- **Per-photo voice:** Each photo can have its own voice selection
- **Playback:** Tap photo to hear the word spoken by selected AI voice

### 5. Communication Interface
- **Photo Grid:** Display all photos in an accessible grid layout
- **Easy Selection:** Large touch targets for easy tapping
- **Tile Preview:** Tap to enlarge photo with audio playback
- **Auto-Close:** Enlarged tile auto-closes after configurable duration (default 2 seconds)
- **Audio Playback:** Custom recording priority, TTS fallback
- **Edit Mode:** Separate edit mode to prevent accidental changes during use

## Technical Architecture

### Technology Stack Options

#### Option 1: Flutter (Recommended)
- **Language:** Dart
- **UI Framework:** Flutter (Cupertino widgets for iOS look)
- **Pros:**
  - Develop on Windows without Mac required
  - Excellent performance (compiled to native ARM code)
  - Hot reload for fast development iteration
  - Strong camera/audio plugin ecosystem
  - Built-in accessibility support
  - Beautiful, native-feeling iPad UI with Cupertino widgets
  - Single codebase for potential future Android version
  - Can test directly on iPad via USB from Windows
- **Cons:**
  - Requires Mac for final App Store build (Rick can help)
  - Slightly larger app size than pure native

#### Option 2: React Native
- **Pros:**
  - JavaScript/TypeScript familiarity
  - Expo Go for easy preview
  - Large community
- **Cons:**
  - Performance overhead with JavaScript bridge
  - More complex native module integration
  - Requires Mac for final build

#### Option 3: Native iOS (Swift)
- **Pros:**
  - Best performance and native feel
  - Direct iOS API access
- **Cons:**
  - Requires Mac for all development
  - Not feasible with current setup

**Recommendation:** Flutter for excellent performance, Windows development capability, and beautiful iPad UI. Rick's Mac only needed for final App Store submission.

### Data Model

```dart
// Drift (SQLite) table definition
class Photos extends Table {
  TextColumn get id => text()(); // UUID string
  TextColumn get imageFileName => text()();
  TextColumn get label => text()();
  TextColumn get customAudioFileName => text().nullable()();
  TextColumn get selectedVoiceId => text().nullable()();
  DateTimeColumn get dateCreated => dateTime()();
  DateTimeColumn get dateModified => dateTime()();
  IntColumn get sortOrder => integer()();
  
  @override
  Set<Column> get primaryKey => {id};
}

// Settings (shared_preferences)
class AppSettings {
  String defaultVoice;           // TTS voice identifier
  int gridColumns;               // 2, 3, or 4 photos per row
  AudioPlaybackMode playbackMode; // CustomFirst, TTS, Custom
  double tileSize;               // 140-360
  double speechRate;             // 0.5-2.0
  double autoCloseDuration;      // 1.0, 2.0, 3.0, 5.0, 0 (manual)
  bool useColorfulTiles;         // true/false
}
```

### Storage Strategy

**Local Storage:**
- **Database:** Drift (Flutter SQLite package) for structured data
- **Files:** path_provider package for local storage
  - Photos: Application Documents directory, organized by UUID
  - Audio recordings: Application Documents directory, AAC format
  - Settings: shared_preferences package
- **Packages:**
  - `drift` - Type-safe SQL database
  - `path_provider` - Access to filesystem directories
  - `shared_preferences` - Key-value storage for settings

**No Cloud Sync Initially:**
- Keep it simple and private
- All data stays on device
- Consider cloud backup later as optional feature

### Audio Implementation

**Recording:**
- `record` package for audio recording
- 5-second limit enforced in UI
- Quality: 44.1kHz, mono, AAC encoding
- File format: .m4a or .aac

**TTS:**
- `flutter_tts` package (uses iOS native TTS under the hood)
- Access to iOS system voices
- Adjustable speech rate and pitch
- Language: Start with English, can expand later

**Playback:**
- `audioplayers` or `just_audio` package
- Priority: Play custom recording if exists, otherwise TTS
- Settings option to choose preference

**Key Packages:**
- `record` - Audio recording
- `flutter_tts` - Text-to-speech
- `audioplayers` - Audio playback
- `permission_handler` - Camera, microphone, photo permissions

## User Interface Design

### Main Screen (Communication Board)
```
[+] Add Photo Button (top right)
[⚙️] Settings (top left)

┌─────────┬─────────┬─────────┐
│ [Photo] │ [Photo] │ [Photo] │
│  Label  │  Label  │  Label  │
├─────────┼─────────┼─────────┤
│ [Photo] │ [Photo] │ [Photo] │
│  Label  │  Label  │  Label  │
└─────────┴─────────┴─────────┘

Large, clear photos with labels
Tap photo → plays audio/TTS
Long press → edit options
```

### Add/Edit Photo Flow
```
1. Photo Selection Screen
   - [Take Photo] button with camera icon
   - [Choose from Library] button
   
2. Label Entry Screen
   - Large text field for single word
   - Keyboard appears automatically
   - [Next] button
   
3. Audio Setup Screen
   - [Record Audio] section
     - Record button (5 sec limit)
     - Playback button
   - [OR]
   - [Choose AI Voice] section
     - Dropdown/picker with voice options
     - [Preview] button to hear each voice
   
4. Confirmation
   - Preview card showing photo + label
   - [Play] to test audio
   - [Save] / [Cancel]
```

### Settings Screen
```
- Default Voice: [Dropdown picker]
- Grid Layout: [2 / 3 / 4 columns]
- Audio Priority: [Custom / TTS / Ask Each Time]
- About / Help
- Data Management (backup/restore later)
```

## Development Phases

### Phase 1: MVP Core (Essential)
- [ ] Project setup (Flutter SDK, VS Code, iPad connection)
- [ ] Photo capture (image_picker package) and upload
- [ ] Photo storage (path_provider, local files)
- [ ] Grid display with GridView (adjustable tile size)
- [ ] Label input (single-word guidance with TextField)
- [ ] TTS integration (flutter_tts package) with default voice
- [ ] Edit mode toggle (using Provider state management)
- [ ] Tap to enlarge + play audio (Hero animation + audio playback)
- [ ] Auto-close after 2 seconds (Timer widget)

### Phase 2: Audio Recording & Settings
- [ ] 5-second audio recording (record package)
- [ ] Audio playback preview (audioplayers package)
- [ ] Audio storage with custom recording priority
- [ ] Settings screen (Navigator push to new route)
- [ ] Auto-close duration setting (1s, 2s, 3s, 5s, Manual)
- [ ] Speech speed control (Slider widget with flutter_tts)

### Phase 3: Voice Selection & Customization
- [ ] Global voice picker UI (settings)
- [ ] Voice preview functionality
- [ ] Tile size adjustment (Small/Medium/Large presets)
- [ ] Edit/delete existing photos
- [ ] Per-photo voice override (optional)

### Phase 4: Polish & Organization
- [ ] Drag-to-reorder tiles (long-press)
- [ ] Multi-select for batch operations
- [ ] Colorful tile backgrounds (optional toggle)
- [ ] VoiceOver support
- [ ] Large text support (Dynamic Type)
- [ ] High contrast mode

### Phase 5: Advanced Features (Future)
- [ ] Folder/category system (organize tiles by topic)
- [ ] Folder thumbnails and navigation
- [ ] Phrases (multiple photos in sequence)
- [ ] iCloud backup (optional)
- [ ] Multiple user profiles
- [ ] Usage analytics for parents (optional, still local-only)

## Accessibility Considerations

- **Large Touch Targets:** Minimum 44x44 points (Apple HIG)
- **High Contrast:** Support light and dark modes
- **VoiceOver:** Full support for screen reader
- **Dynamic Type:** Respect system text size settings
- **Simple Navigation:** Minimize steps to communicate
- **Visual Clarity:** Clear, high-contrast labels and buttons
- **Error Prevention:** Confirm destructive actions

## Privacy & Data Considerations

- **Local First:** All data stored on device
- **No Analytics:** No tracking or data collection
- **Parental Control:** Settings protected by Face ID/passcode (optional)
- **Photo Privacy:** Photos never leave the device
- **Offline Capable:** Full functionality without internet

## Technical Requirements

- **iOS Version:** iOS 12+ (Flutter minimum requirement)
- **Device:** iPad (optimize for iPad screen sizes)
- **Development:** Windows PC with Flutter SDK installed
- **Testing:** iPad connected via USB for live testing
- **Final Build:** Mac required (Rick's Mac for App Store submission)
- **Permissions Required:**
  - Camera access (NSCameraUsageDescription)
  - Photo library access (NSPhotoLibraryUsageDescription)
  - Microphone access (NSMicrophoneUsageDescription)
- **Storage:** Estimate 100-500MB depending on number of photos
- **Flutter Version:** 3.16+ (stable channel)

## Success Criteria

1. **Ease of Use:** Milla can navigate and use the app independently
2. **Reliability:** No crashes, consistent audio playback
3. **Performance:** Instant response to taps (<100ms)
4. **Accessibility:** Works with iOS accessibility features
5. **Flexibility:** Easy for parents to add/modify content

## Future Enhancements to Consider

- Multiple communication boards (home, school, emotions, etc.)
- Sentence builder (combine photos into phrases)
- Customizable themes/colors
- Share board layouts with other families
- Import common AAC symbol sets (Symbolstix, PCS)
- iPad + iPhone sync for portability
- Apple Watch companion (simple favorites)

## Questions to Resolve

1. **Photo Organization:** Should we add categories/folders from the start?
2. **Audio Priority:** Should custom recording always override TTS, or give user choice per-photo?
3. **Voice Selection:** Per-photo or global setting initially?
4. **Grid Size:** Fixed 3x3 or user-configurable?
5. **Onboarding:** First-time tutorial or keep it simple?

## Next Steps

1. Set up Xcode project with SwiftUI
2. Create basic UI mockups
3. Implement photo capture/selection
4. Build Core Data model
5. Develop MVP with TTS only
6. User test with Milla
7. Iterate based on feedback
