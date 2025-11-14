# Flutter Migration Summary

## What Changed

All documentation has been updated from **Swift/SwiftUI/Xcode** to **Flutter/Dart/VS Code** to support development on Windows without a Mac.

---

## Key Technology Changes

| Aspect | Before (Swift) | After (Flutter) |
|--------|---------------|-----------------|
| **Language** | Swift | Dart |
| **UI Framework** | SwiftUI | Flutter (Cupertino widgets) |
| **Database** | Core Data | Drift (SQLite) |
| **Settings Storage** | UserDefaults | shared_preferences |
| **File Storage** | FileManager | path_provider |
| **Photo Picker** | PhotosPicker/UIImagePickerController | image_picker |
| **Audio Recording** | AVAudioRecorder | record package |
| **Text-to-Speech** | AVSpeechSynthesizer | flutter_tts |
| **Audio Playback** | AVAudioPlayer | audioplayers |
| **Permissions** | Info.plist + native | permission_handler |
| **State Management** | @State, @ObservedObject | Provider/Riverpod |
| **Development Platform** | Mac with Xcode | Windows with Flutter SDK |
| **Final Build** | Mac with Xcode | Rick's Mac with Xcode |

---

## Development Workflow

### Old Workflow (Swift)
```
1. Requires Mac for all development
2. Xcode for coding, building, and testing
3. iOS Simulator or iPad for testing
4. Build and submit from same Mac
```

### New Workflow (Flutter)
```
1. Develop on Windows PC
   - Install Flutter SDK
   - Use VS Code or Android Studio
   - Connect iPad via USB for testing
   - Hot reload for instant changes

2. Test on iPad directly from Windows
   - flutter run -d <iPad-id>
   - See changes in real-time
   - No Mac needed for 95% of development

3. Final build on Rick's Mac
   - flutter build ios --release
   - Open in Xcode for signing
   - Submit to App Store
```

---

## Updated Project Structure

### Old Structure (Swift/SwiftUI)
```
StardustAAC/
├── App/
│   └── StardustAACApp.swift
├── Models/ (Core Data)
├── ViewModels/
├── Views/ (SwiftUI)
├── Services/
└── Resources/
```

### New Structure (Flutter)
```
lib/
├── main.dart
├── models/ (Drift tables)
├── providers/ (State management)
├── screens/ (Flutter widgets)
├── widgets/ (Reusable components)
└── services/ (Business logic)
```

---

## Package Dependencies

### Core Packages
```yaml
# State Management
provider: ^6.1.1

# Database
drift: ^2.14.0
sqlite3_flutter_libs: ^0.5.0
path_provider: ^2.1.1

# Media
image_picker: ^1.0.4

# Audio
record: ^5.0.4
flutter_tts: ^3.8.4
audioplayers: ^5.2.1

# Utilities
shared_preferences: ^2.2.2
permission_handler: ^11.1.0
uuid: ^4.2.2
```

---

## Code Example Changes

### Photo Storage

**Before (Swift):**
```swift
let fileManager = FileManager.default
let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
let photoURL = documentsURL.appendingPathComponent("\(uuid).jpg")
try? photoData.write(to: photoURL)
```

**After (Dart/Flutter):**
```dart
import 'package:path_provider/path_provider.dart';

final directory = await getApplicationDocumentsDirectory();
final photoPath = '${directory.path}/$uuid.jpg';
await File(photoPath).writeAsBytes(photoBytes);
```

### Text-to-Speech

**Before (Swift):**
```swift
let synthesizer = AVSpeechSynthesizer()
let utterance = AVSpeechUtterance(string: "Hello")
utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
synthesizer.speak(utterance)
```

**After (Dart/Flutter):**
```dart
import 'package:flutter_tts/flutter_tts.dart';

final tts = FlutterTts();
await tts.setLanguage("en-US");
await tts.speak("Hello");
```

### Grid Layout

**Before (SwiftUI):**
```swift
LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
    ForEach(photos) { photo in
        TileView(photo: photo)
    }
}
```

**After (Flutter):**
```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: photos.length,
  itemBuilder: (context, index) => TileWidget(photo: photos[index]),
)
```

### Database Query

**Before (Core Data + SwiftUI):**
```swift
@FetchRequest(
    sortDescriptors: [SortDescriptor(\.sortOrder)],
    animation: .default
)
private var photos: FetchedResults<Photo>
```

**After (Drift + Flutter):**
```dart
Stream<List<Photo>> watchAllPhotos() {
  return (select(photos)
    ..orderBy([(p) => OrderingTerm.asc(p.sortOrder)]))
    .watch();
}

// In widget:
StreamBuilder<List<Photo>>(
  stream: database.watchAllPhotos(),
  builder: (context, snapshot) {
    final photos = snapshot.data ?? [];
    return GridView.builder(...);
  },
)
```

---

## Benefits of Flutter Approach

### ✅ Advantages
1. **Windows Development** - No Mac needed for 95% of work
2. **Hot Reload** - See UI changes instantly without rebuilding
3. **Hot Restart** - Fast app restart for logic changes
4. **Direct iPad Testing** - Test on real device via USB from Windows
5. **Cross-Platform Future** - Easy to add Android version later
6. **Active Community** - Large Flutter community and packages
7. **Performance** - Compiled to native ARM code (similar to Swift)
8. **Cost Savings** - No need to buy Mac for development

### ⚠️ Trade-offs
1. **App Size** - Slightly larger than pure native (extra ~10-15MB for Flutter framework)
2. **Rick's Mac Still Needed** - For final iOS build and App Store submission
3. **Learning Curve** - Need to learn Dart (but similar to TypeScript/JavaScript)
4. **Debugging iOS Issues** - Some iOS-specific issues harder to debug without Mac

### 🎯 Perfect for This Project
- Milla's needs don't require absolute native performance
- Accessibility features work great in Flutter
- Camera, audio, TTS all have mature Flutter packages
- Can develop on your Windows PC immediately
- Rick only needs to help once at the end

---

## Migration Notes

### What Stays the Same
- ✅ All features and functionality
- ✅ UI design and user experience
- ✅ Privacy-first, local-only approach
- ✅ Accessibility requirements
- ✅ iPad-only focus
- ✅ Development timeline (10-15 weeks)

### What Changes
- ✅ Programming language (Swift → Dart)
- ✅ UI framework (SwiftUI → Flutter)
- ✅ Development tools (Xcode → VS Code/Flutter SDK)
- ✅ Development platform (Mac → Windows)
- ✅ Database (Core Data → Drift)

### Updated Documents
1. ✅ `PROJECT_PLAN.md` - Technology stack, data model, phases
2. ✅ `.github/copilot-instructions.md` - Architecture, patterns, conventions
3. ✅ `QUICK_START.md` - Setup instructions, development workflow
4. ✅ `SUMMARY.md` - Technology references, requirements
5. ✅ `README.md` - Technology section
6. ✅ `DECISIONS.md` - Development environment decision

### Unchanged Documents
- ✅ `UI_MOCKUPS.md` - UI designs are framework-agnostic
- ✅ `SPEECH_ALBUM_ANALYSIS.md` - Feature analysis still relevant
- ✅ `INDEX.md` - Navigation guide still applies

---

## Next Steps

1. **Install Flutter SDK** on your Windows PC
   - Download from https://flutter.dev
   - Add to PATH
   - Run `flutter doctor` to verify

2. **Install VS Code** (or Android Studio)
   - Install Flutter extension
   - Install Dart extension

3. **Connect iPad** to PC via USB
   - Install iTunes (for iPad drivers)
   - Trust computer on iPad
   - Run `flutter devices` to verify

4. **Create Flutter Project**
   - Follow updated `QUICK_START.md`
   - Add dependencies from `pubspec.yaml`
   - Start building!

5. **Develop on Windows**
   - Code in VS Code
   - Hot reload for instant changes
   - Test on iPad via USB
   - 95% of work done here

6. **Final Build with Rick**
   - When ready for App Store
   - Share project with Rick
   - Rick runs `flutter build ios --release`
   - Rick opens in Xcode and submits

---

## Questions?

**Q: Can I test on iPad from Windows?**  
A: Yes! Connect iPad via USB, run `flutter run -d <device-id>`, and you'll see your app on the iPad.

**Q: How often do I need Rick's Mac?**  
A: Only once at the end, for the final App Store build and submission (2-4 hours of his time).

**Q: Is Flutter as good as native Swift for AAC apps?**  
A: Yes! Flutter compiles to native ARM code and has excellent performance. All needed features (camera, audio, TTS, accessibility) are well-supported.

**Q: Can I see UI changes without rebuilding?**  
A: Yes! Flutter's hot reload shows UI changes in <1 second without losing app state.

**Q: What if I want to add Android version later?**  
A: Easy! Same Dart code runs on Android with minimal changes. Just flutter build apk.

**Q: Do I lose any features by using Flutter instead of Swift?**  
A: No! All planned features work great with Flutter packages. Some even have better cross-platform support.

---

## Resources

### Flutter Learning
- [Flutter Official Docs](https://flutter.dev/docs)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Codelabs](https://flutter.dev/docs/codelabs)
- [Flutter Widget Catalog](https://flutter.dev/docs/development/ui/widgets)

### Packages Used
- [drift](https://pub.dev/packages/drift) - Database
- [flutter_tts](https://pub.dev/packages/flutter_tts) - Text-to-speech
- [image_picker](https://pub.dev/packages/image_picker) - Photo picker
- [record](https://pub.dev/packages/record) - Audio recording
- [provider](https://pub.dev/packages/provider) - State management

### Community
- [r/FlutterDev](https://reddit.com/r/FlutterDev) - Reddit community
- [Flutter Discord](https://discord.gg/flutter) - Chat with developers
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter) - Q&A

---

**You're all set! Start with the updated `QUICK_START.md` and begin building Stardust AAC on your Windows PC!** 🚀
