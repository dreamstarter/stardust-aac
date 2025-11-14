import 'package:flutter/foundation.dart';
import '../models/app_settings.dart';

/// Manages app settings
class SettingsProvider with ChangeNotifier {
  AppSettings _settings = AppSettings(defaultVoiceId: '');
  bool _isLoading = false;

  AppSettings get settings => _settings;
  bool get isLoading => _isLoading;

  /// Load settings from SharedPreferences
  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _settings = await AppSettings.load();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update settings
  Future<void> updateSettings(AppSettings newSettings) async {
    _settings = newSettings;
    await _settings.save();
    notifyListeners();
  }

  /// Update a single setting
  Future<void> updateSetting({
    String? defaultVoiceId,
    double? speechRate,
    String? tileSize,
    double? autoCloseDuration,
    bool? useColorfulTiles,
  }) async {
    _settings = _settings.copyWith(
      defaultVoiceId: defaultVoiceId,
      speechRate: speechRate,
      tileSize: tileSize,
      autoCloseDuration: autoCloseDuration,
      useColorfulTiles: useColorfulTiles,
    );
    await _settings.save();
    notifyListeners();
  }
}
