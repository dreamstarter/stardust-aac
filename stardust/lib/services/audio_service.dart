import 'dart:io';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';

/// Handles all audio operations: recording, TTS, and playback
class AudioService {
  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioRecorder _recorder = AudioRecorder();

  bool _isInitialized = false;

  /// Initialize TTS with default settings
  Future<void> initialize() async {
    if (_isInitialized) return;

    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(1.0);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);

    _isInitialized = true;
  }

  /// Get available TTS voices
  Future<List<Map<String, String>>> getAvailableVoices() async {
    await initialize();
    final voices = await _tts.getVoices as List<dynamic>;
    return voices.map((voice) => Map<String, String>.from(voice as Map)).toList();
  }

  /// Set TTS voice by voice ID
  Future<void> setVoice(String voiceId) async {
    await initialize();
    final voices = await getAvailableVoices();
    final selectedVoice = voices.firstWhere(
      (voice) => voice['name'] == voiceId,
      orElse: () => voices.first,
    );
    await _tts.setVoice({
      'name': selectedVoice['name'] ?? '',
      'locale': selectedVoice['locale'] ?? 'en-US',
    });
  }

  /// Set TTS speech rate (0.5 - 2.0)
  Future<void> setSpeechRate(double rate) async {
    await initialize();
    await _tts.setSpeechRate(rate.clamp(0.5, 2.0));
  }

  /// Play audio with priority: custom recording > TTS
  Future<void> playAudio({
    required String label,
    String? customAudioPath,
    String? voiceId,
    double speechRate = 1.0,
  }) async {
    await initialize();

    // Priority 1: Custom audio recording
    if (customAudioPath != null) {
      final file = File(customAudioPath);
      if (await file.exists()) {
        await _audioPlayer.play(DeviceFileSource(customAudioPath));
        return;
      }
    }

    // Priority 2: TTS with specified voice
    if (voiceId != null) {
      await setVoice(voiceId);
    }
    await setSpeechRate(speechRate);
    await _tts.speak(label);
  }

  /// Start recording audio (5-second limit enforced by caller)
  Future<void> startRecording(String outputPath) async {
    if (await _recorder.hasPermission()) {
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          sampleRate: 22050,
          numChannels: 1,
        ),
        path: outputPath,
      );
    } else {
      throw Exception('Microphone permission not granted');
    }
  }

  /// Stop recording and return the file path
  Future<String?> stopRecording() async {
    return await _recorder.stop();
  }

  /// Check if currently recording
  Future<bool> isRecording() async {
    return await _recorder.isRecording();
  }

  /// Stop any currently playing audio
  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    await _tts.stop();
  }

  /// Dispose resources
  Future<void> dispose() async {
    await _audioPlayer.dispose();
    await _recorder.dispose();
  }
}
