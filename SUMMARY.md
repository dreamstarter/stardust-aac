# Stardust AAC - Project Summary

## What We've Planned

This document summarizes the planning work completed for **Stardust AAC**, an iPad communication app for Milla.

---

## 📚 Documents Created

1. **`PROJECT_PLAN.md`** - Complete technical specification with architecture, data models, and development phases
2. **`README.md`** - Project overview and introduction
3. **`.github/copilot-instructions.md`** - Guidelines for AI coding assistants during development
4. **`DECISIONS.md`** - Open questions and decisions to be made
5. **`SPEECH_ALBUM_ANALYSIS.md`** - Feature analysis of reference app with adoption recommendations
6. **`SUMMARY.md`** (this file) - Quick reference guide

---

## 🎯 Core Concept

**Stardust AAC** helps Milla communicate using:
- 📸 Photos (captured or uploaded)
- 🏷️ Simple word labels
- 🎙️ Custom 5-second audio recordings (parent's voice)
- 🤖 iOS text-to-speech voices

**Platform:** Native iOS (iPad) with Swift + SwiftUI

---

## ✨ Key Features (Inspired by Speech Album)

### Communication Mode
1. **Tap tile** → Enlarges + plays audio
2. **Audio priority:** Custom recording first, TTS fallback
3. **Auto-close:** Returns to grid after 2 seconds (configurable)
4. **Large tiles:** Easy tapping for motor skill challenges

### Edit Mode
1. **Toggle edit mode** (pencil icon) to prevent accidental changes
2. Add photos (camera or library)
3. Add labels and audio
4. Delete or reorder tiles

### Settings
- 🎤 Voice selection and speech speed
- 📐 Tile size adjustment
- ⏱️ Auto-close duration (1s, 2s, 3s, 5s, Manual)
- 🎨 Optional colorful tile backgrounds

---

## 🗂️ Data Architecture

### Photo Entity (Drift/SQLite)
```dart
class Photos extends Table {
  TextColumn get id => text()();  // UUID
  TextColumn get imageFileName => text()();
  TextColumn get label => text()();
  TextColumn get customAudioFileName => text().nullable()();
  TextColumn get selectedVoiceId => text().nullable()();
  DateTimeColumn get dateCreated => dateTime()();
  IntColumn get sortOrder => integer()();
}
```

### Settings (shared_preferences)
```dart
class AppSettings {
  String defaultVoiceId;
  double speechRate;
  String tileSize;  // 'small', 'medium', 'large'
  double autoCloseDuration;
  bool useColorfulTiles;
}
```

### Storage
- **Photos:** Documents directory (path_provider), UUID filenames
- **Audio:** Documents directory, AAC format
- **Database:** Drift (SQLite)
- **Privacy:** Everything stays local, no cloud sync

---

## 🚀 Development Phases

### Phase 1: MVP Core (4-6 weeks)
- ✅ Photo capture/upload
- ✅ Label input
- ✅ Grid display with tiles
- ✅ TTS with default voice
- ✅ Edit mode toggle
- ✅ Tap to enlarge + play
- ✅ Auto-close (2 sec fixed)

### Phase 2: Audio & Settings (2-3 weeks)
- ✅ 5-second audio recording
- ✅ Custom recording priority
- ✅ Settings screen
- ✅ Auto-close duration setting
- ✅ Speech speed control

### Phase 3: Customization (2-3 weeks)
- ✅ Global voice selection
- ✅ Tile size adjustment
- ✅ Edit/delete photos
- ✅ Per-photo voice override (optional)

### Phase 4: Polish (2-3 weeks)
- ✅ Drag-to-reorder
- ✅ Multi-select
- ✅ Colorful tiles (toggle)
- ✅ VoiceOver support
- ✅ Dynamic Type

### Phase 5: Advanced (Future)
- ✅ Folder/category system
- ✅ Phrase building (multiple photos)
- ✅ iCloud backup (optional)
- ✅ Multiple user profiles

**Total Estimated MVP Time:** 10-15 weeks (part-time development)

---

## 🔑 Key Design Decisions

### ✅ Decided
1. **Platform:** Flutter/Dart - develop on Windows, build on Rick's Mac
2. **Audio Priority:** Custom recording > TTS
3. **Edit Mode:** Separate mode with toggle (child-proof)
4. **Auto-Close:** Default 2 seconds, configurable in settings
5. **Tile Interaction:** Enlarge on tap with audio playback
6. **Privacy:** Local-only, no cloud, no analytics
7. **Voice:** Start with global, add per-photo override later
8. **Audio Format:** 22kHz mono AAC (balance of quality and size)
9. **Development:** 95% on Windows, Rick helps with final App Store submission

### ❓ Still to Decide (see DECISIONS.md)
1. Grid layout: Fixed or user-adjustable columns?
2. Label validation: Strict single-word or guidance only?
3. Category timing: MVP or Phase 5?
4. Photo editing: Crop/rotate needed?
5. Development environment: Do you have Mac + Xcode?

---

## 🎨 UI/UX Flow

### Communication Mode (Child View)
```
┌──────────────────────────────────┐
│  [✏️ Edit]         [⚙️ Settings]  │
├──────────────────────────────────┤
│                                  │
│  ┌───────┐  ┌───────┐  ┌───────┐│
│  │ Photo │  │ Photo │  │ Photo ││
│  │ Label │  │ Label │  │ Label ││
│  └───────┘  └───────┘  └───────┘│
│                                  │
│  ┌───────┐  ┌───────┐  ┌───────┐│
│  │ Photo │  │ Photo │  │ Photo ││
│  │ Label │  │ Label │  │ Label ││
│  └───────┘  └───────┘  └───────┘│
│                                  │
└──────────────────────────────────┘

Tap tile → Enlarges + plays audio → Auto-closes
```

### Edit Mode (Parent View)
```
┌──────────────────────────────────┐
│  [Done]  [+]             [🗑️ Del]│
├──────────────────────────────────┤
│  Selection indicators visible     │
│  Long-press to drag & reorder     │
│  Tap to edit label/audio          │
└──────────────────────────────────┘
```

---

## 🛡️ Privacy & Accessibility

### Privacy (100% Local)
- ✅ No internet required
- ✅ No data collection
- ✅ No analytics/tracking
- ✅ No third-party services
- ✅ All data in Documents directory
- ✅ Permissions used locally only

### Accessibility (AAC Requirements)
- ✅ Large touch targets (44pt minimum)
- ✅ VoiceOver support
- ✅ Dynamic Type (text sizing)
- ✅ High contrast mode
- ✅ Simple navigation
- ✅ Immediate feedback

---

## 📖 Reference Materials

### Inspiration
- **Speech Album App:** https://github.com/larrj/speechalbumapp
  - Similar AAC app with proven UX patterns
  - Analyzed in `SPEECH_ALBUM_ANALYSIS.md`

### Apple Documentation
- [iOS Accessibility](https://developer.apple.com/accessibility/)
- [AVSpeechSynthesizer](https://developer.apple.com/documentation/avfaudio/speech_synthesis)
- [AVAudioRecorder](https://developer.apple.com/documentation/avfaudio/avaudiorecorder)
- [Core Data](https://developer.apple.com/documentation/coredata)

### AAC Resources
- [ASHA AAC Portal](https://www.asha.org/practice-portal/professional-issues/augmentative-and-alternative-communication/)

---

### Technical Requirements

### Development
- **Computer:** Windows PC with Flutter SDK installed
- **Test Device:** iPad running iOS 12.0+ connected via USB
- **Final Build:** Rick's Mac for App Store submission
- **Apple Developer Account:** Free for device testing, $99/year for App Store
- **Permissions:** Camera, Photo Library, Microphone

### App Requirements
- **iOS Version:** 16.0+
- **Device:** iPad (all sizes)
- **Storage:** ~100-500MB depending on usage
- **Network:** None required (fully offline)

---

## 📝 Next Steps

### Before Development
1. ✅ Review `DECISIONS.md` and make final decisions
2. ⬜ Confirm development environment (Mac + Xcode)
3. ⬜ Get test iPad ready
4. ⬜ Review Speech Album app for UX inspiration (optional)

### Starting Development
1. ⬜ Install Flutter SDK on Windows
2. ⬜ Create Flutter project
3. ⬜ Set up Drift database model
4. ⬜ Create basic UI with Cupertino widgets
5. ⬜ Implement photo capture (image_picker)
6. ⬜ Build grid view (GridView.builder)
7. ⬜ Add TTS integration (flutter_tts)

### Testing with Milla
1. ⬜ Add 5-10 meaningful photos
2. ⬜ Observe usage patterns
3. ⬜ Identify pain points
4. ⬜ Iterate on features

---

## 💝 Remember

This app is for **Milla**. Every design decision should prioritize:
1. **Simplicity** - Can she use it independently?
2. **Reliability** - Does it work every time?
3. **Joy** - Is it delightful to use?
4. **Empowerment** - Does it help her communicate her needs?

Keep it simple. Keep it fast. Keep it meaningful. ✨

---

## Questions?

Refer to:
- **Technical details:** `PROJECT_PLAN.md`
- **Open decisions:** `DECISIONS.md`
- **Feature analysis:** `SPEECH_ALBUM_ANALYSIS.md`
- **Development guide:** `.github/copilot-instructions.md`
