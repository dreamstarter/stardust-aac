import 'package:shared_preferences/shared_preferences.dart';

/// App settings stored in SharedPreferences
class AppSettings {
  static const String _keyDefaultVoiceId = 'defaultVoiceId';
  static const String _keySpeechRate = 'speechRate';
  static const String _keyTileSize = 'tileSize';
  static const String _keyAutoCloseDuration = 'autoCloseDuration';
  static const String _keyUseColorfulTiles = 'useColorfulTiles';

  final String defaultVoiceId;
  final double speechRate; // 0.5 - 2.0
  final String tileSize; // 'small', 'medium', 'large'
  final double autoCloseDuration; // 1.0, 2.0, 3.0, 5.0, 0 (manual)
  final bool useColorfulTiles;

  AppSettings({
    required this.defaultVoiceId,
    this.speechRate = 1.0,
    this.tileSize = 'medium',
    this.autoCloseDuration = 2.0,
    this.useColorfulTiles = true,
  });

  /// Load settings from SharedPreferences
  static Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return AppSettings(
      defaultVoiceId: prefs.getString(_keyDefaultVoiceId) ?? '',
      speechRate: prefs.getDouble(_keySpeechRate) ?? 1.0,
      tileSize: prefs.getString(_keyTileSize) ?? 'medium',
      autoCloseDuration: prefs.getDouble(_keyAutoCloseDuration) ?? 2.0,
      useColorfulTiles: prefs.getBool(_keyUseColorfulTiles) ?? true,
    );
  }

  /// Save settings to SharedPreferences
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyDefaultVoiceId, defaultVoiceId);
    await prefs.setDouble(_keySpeechRate, speechRate);
    await prefs.setString(_keyTileSize, tileSize);
    await prefs.setDouble(_keyAutoCloseDuration, autoCloseDuration);
    await prefs.setBool(_keyUseColorfulTiles, useColorfulTiles);
  }

  /// Create a copy with updated values
  AppSettings copyWith({
    String? defaultVoiceId,
    double? speechRate,
    String? tileSize,
    double? autoCloseDuration,
    bool? useColorfulTiles,
  }) {
    return AppSettings(
      defaultVoiceId: defaultVoiceId ?? this.defaultVoiceId,
      speechRate: speechRate ?? this.speechRate,
      tileSize: tileSize ?? this.tileSize,
      autoCloseDuration: autoCloseDuration ?? this.autoCloseDuration,
      useColorfulTiles: useColorfulTiles ?? this.useColorfulTiles,
    );
  }
}
