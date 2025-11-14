# Quick Start Guide - Stardust AAC

This guide will help you go from planning to development on Windows.

---

## 📋 Pre-Development Checklist

### Required Hardware & Software

- [ ] Windows PC (Windows 10 or 11)
- [ ] iPad for testing (iOS 12.0+)
- [ ] Lightning/USB-C cable to connect iPad to PC
- [ ] At least 10GB free disk space (for Flutter SDK and tools)
- [ ] Rick's Mac (for final App Store submission only)

### Development Environment Setup

- [ ] Flutter SDK installed (https://flutter.dev/docs/get-started/install/windows)
- [ ] Android Studio OR VS Code installed (recommend VS Code for lighter install)
- [ ] Git for Windows (https://git-scm.com/download/win)
- [ ] Apple ID created (free, needed for device testing)
- [ ] iTunes installed (needed for iPad drivers on Windows)

### iPad Setup

- [ ] iPad updated to iOS 12.0 or later
- [ ] Developer mode enabled (Settings > Privacy & Security > Developer Mode)
- [ ] Trust computer when connecting iPad

### Knowledge Prerequisites

- [ ] Basic Dart programming knowledge (similar to JavaScript/TypeScript/Java)
- [ ] Flutter fundamentals (widgets, state, StatefulWidget/StatelessWidget)
- [ ] Basic understanding of mobile app development
- [ ] Git for version control (recommended)

---

## 🚀 Day 1: Project Setup (2-3 hours)

### Step 1: Install Flutter SDK

```powershell
# Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
# Extract to C:\flutter (or your preferred location)

# Add to PATH:
# System Properties > Environment Variables > Path > Add C:\flutter\bin

# Verify installation:
flutter doctor

# Install VS Code Flutter extension (recommended) or Android Studio Flutter plugin
```

### Step 2: Create Flutter Project

```powershell
# Navigate to your workspace
cd D:\Development\personal\stardust-acc

# Create Flutter project
flutter create --org com.yourname --project-name stardust_aac .

# If directory not empty, create in subfolder and move files:
flutter create --org com.yourname --project-name stardust_aac stardust_aac_app
```

### Step 3: Configure iOS Permissions

Edit `ios/Runner/Info.plist` and add:

```xml
<key>NSCameraUsageDescription</key>
<string>Stardust AAC needs camera access to take photos for communication tiles.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Stardust AAC needs photo library access to select existing photos.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Stardust AAC needs microphone access to record custom audio for tiles.</string>
<key>UIRequiresFullScreen</key>
<true/>
```

### Step 4: Install Dependencies

Edit `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State management
  provider: ^6.1.1
  
  # Database
  drift: ^2.14.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.1
  path: ^1.8.0
  
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

dev_dependencies:
  flutter_test:
    sdk: flutter
  drift_dev: ^2.14.0
  build_runner: ^2.4.7
```

Run:

```powershell
flutter pub get
```

### Step 5: Initial File Structure

```
lib/
├── main.dart (app entry point)
├── models/
│   ├── database.dart (Drift database)
│   ├── photo.dart (Photo table)
│   └── app_settings.dart (Settings model)
├── providers/
│   ├── edit_mode_provider.dart
│   └── photos_provider.dart
├── screens/
│   ├── communication_board_screen.dart
│   ├── settings_screen.dart
│   └── add_photo_flow/
│       ├── photo_source_screen.dart
│       ├── label_entry_screen.dart
│       └── audio_setup_screen.dart
├── widgets/
│   ├── tile_widget.dart
│   └── tile_preview_overlay.dart
└── services/
    ├── audio_service.dart
    ├── storage_service.dart
    └── database_service.dart
```

### Step 6: Connect iPad to Windows PC

```powershell
# Connect iPad via USB cable
# Trust computer on iPad when prompted
# Install iTunes if not already installed (provides iPad drivers)

# Check connected devices:
flutter devices

# Should show your iPad: "<iPad Name> (mobile) • <ID> • ios • iOS <version>"

# Run app on iPad:
flutter run -d <device-id>
```

---

## 📅 Week 1: MVP Foundation (15-20 hours)

### Day 1-2: Basic UI Structure

- [ ] Create main `CommunicationBoardScreen` StatefulWidget
- [ ] Add CupertinoNavigationBar with Edit and Settings buttons
- [ ] Create simple grid layout (GridView.builder, 3 columns)
- [ ] Add placeholder tiles with Container and Text widgets
- [ ] Test on iPad via USB (`flutter run`)

**Goal:** See a grid of placeholder tiles

### Day 3-4: Photo Capture & Storage

- [ ] Request permissions with permission_handler
- [ ] Implement image_picker for camera and gallery
- [ ] Save photos to Documents directory using path_provider
- [ ] Generate UUID filenames with uuid package
- [ ] Test photo capture workflow

**Goal:** Take/select photo and see it saved

### Day 5-6: Drift Database Integration

- [ ] Create Drift database configuration in `models/database.dart`
- [ ] Define Photos table with Drift
- [ ] Create `DatabaseService` wrapper
- [ ] Implement save photo with label
- [ ] Implement fetch all photos
- [ ] Display real photos in grid using StreamBuilder
- [ ] Test CRUD operations

**Goal:** Photos persist and display in grid

### Day 7: Text-to-Speech

- [ ] Create `AudioService` class
- [ ] Implement basic TTS with flutter_tts
- [ ] Configure iOS voice
- [ ] Play label when tile tapped
- [ ] Test with different voices

**Goal:** Tap tile → hear word spoken

---

## 📅 Week 2: Tile Interaction & Edit Mode (15-20 hours)

### Day 1-2: Tile Preview

- [ ] Create `TilePreviewView` as modal overlay
- [ ] Show enlarged photo + label on tap
- [ ] Play audio when preview opens
- [ ] Add 2-second auto-close timer
- [ ] Add tap-to-dismiss

**Goal:** Tap tile → enlarges → plays → auto-closes

### Day 3-4: Edit Mode

- [ ] Add `@State var isEditMode` to main view
- [ ] Toggle edit mode with button
- [ ] Show/hide edit controls
- [ ] Prevent tile preview in edit mode
- [ ] Add selection indicators

**Goal:** Edit mode toggles, visual changes visible

### Day 5-6: Add Photo Flow

- [ ] Create multi-step add photo sheet
- [ ] Step 1: Photo source selection
- [ ] Step 2: Label entry
- [ ] Step 3: Save to Core Data
- [ ] Test complete flow

**Goal:** Add photo with label through UI

### Day 7: Polish & Testing

- [ ] Delete photo functionality
- [ ] Error handling (permissions, storage)
- [ ] Test on real iPad
- [ ] Fix any bugs

**Goal:** Basic app works reliably

---

## 📅 Week 3: Audio Recording (10-15 hours)

### Day 1-2: Recording Setup

- [ ] Add AVAudioRecorder setup
- [ ] Request microphone permission
- [ ] Configure audio session
- [ ] Save recordings to Documents
- [ ] Test basic recording

### Day 3-4: Recording UI

- [ ] Add recording controls to add photo flow
- [ ] Show 5-second timer
- [ ] Add record/stop/play buttons
- [ ] Visual feedback during recording
- [ ] Preview recorded audio

### Day 5: Audio Priority Logic

- [ ] Update `AudioService` to check for custom audio
- [ ] Fallback to TTS if no recording
- [ ] Test both scenarios
- [ ] Handle errors gracefully

**Goal:** Custom recordings work and take priority

---

## 📅 Week 4: Settings & Polish (10-15 hours)

### Day 1-2: Settings Screen

- [ ] Create `SettingsView`
- [ ] Add Display section (tile size)
- [ ] Add Voice section (voice picker, speech speed)
- [ ] Add Behavior section (auto-close duration)
- [ ] Save to UserDefaults

### Day 3-4: Apply Settings

- [ ] Read settings on app launch
- [ ] Apply tile size to grid
- [ ] Apply voice to TTS
- [ ] Apply auto-close duration
- [ ] Test all settings work

### Day 5: MVP Completion

- [ ] Test all features end-to-end
- [ ] Fix any bugs
- [ ] Test with Milla (if possible)
- [ ] Document any issues

**Goal:** MVP feature-complete and tested

---

## 🧪 Testing Strategy

### Manual Testing (Every Day)

1. Run on iPad simulator
2. Test new features added
3. Test existing features still work
4. Note any bugs or issues

### Device Testing (Weekly)

1. Connect iPad via cable
2. Build and run on device
3. Test camera and microphone
4. Test performance and responsiveness
5. Get feedback from Milla

### Accessibility Testing (Phase 4)

1. Enable VoiceOver
2. Test navigation with VoiceOver
3. Test with larger text sizes
4. Test in high contrast mode

---

## 🐛 Troubleshooting

### Common Issues

**"Signing for StardustAAC requires a development team"**

- Solution: Select your Apple ID under Signing & Capabilities > Team

**"Failed to launch app on device"**

- Solution: Enable Developer Mode on iPad (Settings > Privacy & Security)

**"Camera permission denied"**

- Solution: Add NSCameraUsageDescription to Info.plist

**"App crashes when tapping tile"**

- Solution: Check AudioService initialization, ensure AVSpeechSynthesizer is set up

**"Photos not persisting"**

- Solution: Verify Core Data save is being called, check for errors

**"Recording not working"**

- Solution: Check microphone permission, audio session configuration

---

## 📚 Learning Resources

### Essential Documentation

- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui) - Apple's official tutorials
- [Core Data](https://developer.apple.com/documentation/coredata) - Data persistence
- [AVFoundation](https://developer.apple.com/av-foundation/) - Audio and camera
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios) - iOS design

### Recommended Tutorials

- [Hacking with Swift - 100 Days of SwiftUI](https://www.hackingwithswift.com/100/swiftui) - Free course
- [Stanford CS193p](https://cs193p.sites.stanford.edu/) - SwiftUI course
- [Paul Hudson's SwiftUI by Example](https://www.hackingwithswift.com/quick-start/swiftui) - Quick reference

### Video Resources

- WWDC sessions on SwiftUI, Core Data, AVFoundation
- YouTube channels: Sean Allen, Kavsoft, Stewart Lynch

---

## 🎯 Success Criteria

### MVP is complete when:

- [ ] Can add photos from camera or library
- [ ] Can add labels to photos
- [ ] Photos display in grid
- [ ] Tapping tile shows preview
- [ ] Audio plays (TTS)
- [ ] Preview auto-closes
- [ ] Edit mode prevents accidental taps
- [ ] App works reliably on iPad
- [ ] Milla can use basic features

### Ready for Phase 2 when:

- [ ] All MVP features work
- [ ] No critical bugs
- [ ] Performance is smooth
- [ ] Tested on real device
- [ ] Feedback incorporated

---

## 💡 Development Tips

### Daily Workflow
1. Start with small, testable changes
2. Build and run frequently (⌘R)
3. Test on simulator after each feature
4. Commit to git after working features
5. Test on device at end of day

### Code Organization
- Keep files small and focused
- Separate views, view models, and services
- Use meaningful variable names
- Comment complex logic
- Follow Swift naming conventions

### SwiftUI Best Practices
- Use `@State` for view-local state
- Use `@StateObject` for view models
- Use `@EnvironmentObject` for shared state
- Keep views small and composable
- Preview in Xcode canvas frequently

### Core Data Best Practices
- Use background contexts for heavy operations
- Save context after changes
- Handle errors gracefully
- Use fetch requests efficiently
- Test with sample data first

### Audio Best Practices
- Request permissions early
- Handle permission denial gracefully
- Configure audio session properly
- Test with device sound on/off
- Handle interruptions (phone calls)

---

## 📞 Getting Help

### When Stuck
1. Check error messages in Xcode console
2. Search Apple Developer Forums
3. Search Stack Overflow
4. Review project documentation (SUMMARY.md, PROJECT_PLAN.md)
5. Break problem into smaller parts
6. Try simplest solution first

### Useful AI Prompts
- "How do I implement [feature] in SwiftUI?"
- "Why is my Core Data save not working?"
- "How to handle camera permissions in iOS?"
- "SwiftUI grid layout best practices"

---

## 🎉 Next Steps After MVP

1. **User Testing**
   - Use app with Milla daily
   - Note what works well
   - Note what's confusing
   - Track communication patterns

2. **Iteration**
   - Fix bugs discovered
   - Adjust based on feedback
   - Refine UX details
   - Optimize performance

3. **Phase 2 Planning**
   - Prioritize audio recording
   - Design settings interface
   - Plan implementation

4. **Community**
   - Share progress (if comfortable)
   - Get feedback from AAC community
   - Consider open sourcing (optional)

---

## 🌟 Remember

**Start small.** Get one feature working before moving to the next.

**Test often.** Run the app every time you make a change.

**Keep it simple.** The goal is helping Milla communicate, not building a complex app.

**Iterate based on use.** Real usage will reveal what works and what doesn't.

**Have fun!** You're building something meaningful for someone you love. ✨

---

Ready to start? Open Xcode and create that project! 🚀
