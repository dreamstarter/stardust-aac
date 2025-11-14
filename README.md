# Stardust AAC

An Augmentative and Alternative Communication (AAC) application for iPad, designed to help individuals with speech and language challenges communicate using photo-based cards with text-to-speech.

Built with love for Milla. ✨

## What is AAC?

Augmentative and Alternative Communication (AAC) helps people with speech and language challenges communicate. This app uses pictures with labels that can be spoken aloud, helping bridge communication gaps.

## Features

- 📸 **Photo-Based Communication** - Take photos or use existing ones from your device
- 🏷️ **Simple Labels** - One-word descriptions for each photo
- 🎙️ **Custom Audio** - Record 5-second audio clips in a familiar voice
- 🤖 **AI Voices** - Choose from iOS text-to-speech voices
- 💾 **Local Storage** - All data stays private on your device
- 📱 **iPad Optimized** - Large, accessible interface designed for easy interaction

## Purpose

This app is designed to be:

- **Simple** - Easy enough for independent use
- **Fast** - Immediate response to taps
- **Flexible** - Customizable for individual needs
- **Private** - No data collection, no internet required
- **Accessible** - Works with iOS accessibility features

## Technology

- **Platform:** iOS 12+ (iPad)
- **Language:** Dart
- **Framework:** Flutter
- **Storage:** Drift (SQLite) + local files
- **Audio:** record, flutter_tts, audioplayers packages
- **Development:** Windows PC, final build on Mac

## Project Status

🚧 **Planning Phase** - See [PROJECT_PLAN.md](PROJECT_PLAN.md) for detailed specifications.

## Development Setup

### Prerequisites
- Windows 10/11 PC (or Mac)
- Flutter SDK 3.16+ ([Install Flutter](https://flutter.dev/docs/get-started/install))
- VS Code with Flutter extension (recommended) or Android Studio
- iPad with iOS 12+ for testing
- USB cable to connect iPad
- iTunes (for iPad drivers on Windows)

### Quick Start

```powershell
# Clone the repository
git clone https://github.com/dreamstarter/stardust-aac.git
cd stardust-aac/stardust

# Install dependencies
flutter pub get

# Generate database code
dart run build_runner build --delete-conflicting-outputs

# Connect iPad via USB and run
flutter devices
flutter run -d <device-id>
```

See [SETUP_COMPLETE.md](SETUP_COMPLETE.md) for detailed setup information.

## Contributing

This is a personal project built for Milla. If you're working on similar AAC tools, feel free to reach out or fork the project.

## License

_To be determined_

## Resources

- [Apple Accessibility Documentation](https://developer.apple.com/accessibility/)
- [iOS Speech Framework](https://developer.apple.com/documentation/avfaudio/speech_synthesis)
- [AAC Best Practices](https://www.asha.org/practice-portal/professional-issues/augmentative-and-alternative-communication/)
