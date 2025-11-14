import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/database.dart';
import '../../providers/photos_provider.dart';
import '../../services/storage_service.dart';
import '../../services/audio_service.dart';

/// Third step in add photo flow: record audio or select TTS voice
class AudioSetupScreen extends StatefulWidget {
  final File imageFile;
  final String label;

  const AudioSetupScreen({
    super.key,
    required this.imageFile,
    required this.label,
  });

  @override
  State<AudioSetupScreen> createState() => _AudioSetupScreenState();
}

class _AudioSetupScreenState extends State<AudioSetupScreen> {
  String? _recordedAudioPath;
  String? _selectedVoiceId;
  String? _selectedVoiceName;
  bool _isRecording = false;
  int _recordingSecondsLeft = 5;
  Timer? _recordingTimer;
  List<Map<String, String>> _availableVoices = [];
  bool _loadingVoices = false;

  @override
  void initState() {
    super.initState();
    _loadAvailableVoices();
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadAvailableVoices() async {
    setState(() => _loadingVoices = true);
    try {
      final audioService = context.read<AudioService>();
      final voices = await audioService.getAvailableVoices();
      setState(() {
        _availableVoices = voices;
        _loadingVoices = false;
      });
    } catch (e) {
      setState(() => _loadingVoices = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Add Audio'),
        previousPageTitle: 'Back',
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Photo and label preview
              _buildPhotoPreview(),
              
              const SizedBox(height: 32),
              
              const Text(
                'How should it sound?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              // Record audio section
              _buildRecordAudioSection(),
              
              const SizedBox(height: 24),
              
              // OR divider
              _buildDivider(),
              
              const SizedBox(height: 24),
              
              // TTS voice selection
              _buildVoiceSelectionSection(),
              
              const SizedBox(height: 32),
              
              // Save button
              CupertinoButton.filled(
                onPressed: _canSave ? _handleSave : null,
                child: const Text(
                  'Save Photo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoPreview() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.file(
              widget.imageFile,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordAudioSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _recordedAudioPath != null
              ? CupertinoColors.activeGreen
              : CupertinoColors.systemGrey4,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            CupertinoIcons.mic_fill,
            size: 48,
            color: CupertinoColors.systemRed,
          ),
          const SizedBox(height: 12),
          const Text(
            'Record Audio',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _recordedAudioPath != null
                ? 'Recording saved ✓'
                : 'Record in your voice (5 seconds)',
            style: TextStyle(
              fontSize: 14,
              color: _recordedAudioPath != null
                  ? CupertinoColors.activeGreen
                  : CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 16),
          if (_isRecording) ...[
            Text(
              '$_recordingSecondsLeft',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.systemRed,
              ),
            ),
            const SizedBox(height: 8),
            CupertinoButton(
              onPressed: _stopRecording,
              child: const Text('Stop'),
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CupertinoButton.filled(
                  onPressed: _startRecording,
                  child: const Text('Record'),
                ),
                if (_recordedAudioPath != null) ...[
                  const SizedBox(width: 12),
                  CupertinoButton(
                    onPressed: _playRecording,
                    child: const Icon(CupertinoIcons.play_fill),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: CupertinoColors.systemGrey4)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: CupertinoColors.systemGrey4)),
      ],
    );
  }

  Widget _buildVoiceSelectionSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _selectedVoiceId != null && _recordedAudioPath == null
              ? CupertinoColors.activeBlue
              : CupertinoColors.systemGrey4,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            CupertinoIcons.speaker_3_fill,
            size: 48,
            color: CupertinoColors.activeBlue,
          ),
          const SizedBox(height: 12),
          const Text(
            'Use Text-to-Speech',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Use a computer voice',
            style: TextStyle(
              fontSize: 14,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(height: 16),
          CupertinoButton.filled(
            onPressed: _loadingVoices ? null : _showVoicePicker,
            child: Text(_selectedVoiceName ?? 'Select Voice'),
          ),
          if (_selectedVoiceId != null) ...[
            const SizedBox(height: 12),
            CupertinoButton(
              onPressed: _previewVoice,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.play_fill),
                  SizedBox(width: 8),
                  Text('Preview'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool get _canSave {
    return _recordedAudioPath != null || _selectedVoiceId != null;
  }

  Future<void> _startRecording() async {
    // Request microphone permission
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      if (mounted) {
        _showPermissionDeniedDialog('Microphone');
      }
      return;
    }

    try {
      final storageService = StorageService();
      final audioService = context.read<AudioService>();
      
      // Generate temporary path for recording
      final filename = storageService.generateAudioFilename();
      final tempPath = await storageService.getAudioPath(filename);
      
      // Start recording
      await audioService.startRecording(tempPath);
      
      setState(() {
        _isRecording = true;
        _recordingSecondsLeft = 5;
        _recordedAudioPath = tempPath;
      });

      // Start countdown timer
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _recordingSecondsLeft--;
        });

        if (_recordingSecondsLeft <= 0) {
          _stopRecording();
        }
      });
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to start recording: $e');
      }
    }
  }

  Future<void> _stopRecording() async {
    _recordingTimer?.cancel();
    
    try {
      final audioService = context.read<AudioService>();
      await audioService.stopRecording();
      
      setState(() {
        _isRecording = false;
      });
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to stop recording: $e');
      }
    }
  }

  Future<void> _playRecording() async {
    if (_recordedAudioPath == null) return;

    try {
      final audioService = context.read<AudioService>();
      await audioService.playAudio(
        label: widget.label,
        customAudioPath: _recordedAudioPath,
      );
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to play recording: $e');
      }
    }
  }

  void _showVoicePicker() {
    if (_availableVoices.isEmpty) {
      _showErrorDialog('No voices available. Please try again.');
      return;
    }

    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground,
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator,
                    width: 0.5,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Text(
                    'Select Voice',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Done'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
            // Voice list
            Expanded(
              child: CupertinoPicker(
                itemExtent: 44,
                onSelectedItemChanged: (index) {
                  final voice = _availableVoices[index];
                  setState(() {
                    _selectedVoiceId = voice['name'];
                    _selectedVoiceName = '${voice['name']} (${voice['locale']})';
                  });
                },
                children: _availableVoices.map((voice) {
                  return Center(
                    child: Text(
                      '${voice['name']} (${voice['locale']})',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _previewVoice() async {
    if (_selectedVoiceId == null) return;

    try {
      final audioService = context.read<AudioService>();
      await audioService.playAudio(
        label: widget.label,
        voiceId: _selectedVoiceId,
      );
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to preview voice: $e');
      }
    }
  }

  void _showPermissionDeniedDialog(String permissionType) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('$permissionType Permission Required'),
        content: Text(
          'Please enable $permissionType access in Settings to record audio.',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Open Settings'),
            onPressed: () {
              Navigator.of(context).pop();
              openAppSettings();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave() async {
    if (!_canSave) return;

    // Show loading indicator
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CupertinoActivityIndicator(radius: 20),
      ),
    );

    try {
      final storageService = StorageService();
      final photosProvider = context.read<PhotosProvider>();

      // 1. Save image file to documents directory
      final imageFileName = await storageService.saveImageFile(widget.imageFile);

      // 2. Copy audio recording if exists
      String? audioFileName;
      if (_recordedAudioPath != null) {
        final audioFile = File(_recordedAudioPath!);
        if (await audioFile.exists()) {
          audioFileName = storageService.generateAudioFilename();
          final targetPath = await storageService.getAudioPath(audioFileName);
          await audioFile.copy(targetPath);
        }
      }

      // 3. Create photo record
      final photo = PhotosCompanion(
        id: drift.Value(const Uuid().v4()),
        imageFileName: drift.Value(imageFileName),
        label: drift.Value(widget.label),
        customAudioFileName: drift.Value(audioFileName),
        selectedVoiceId: drift.Value(_selectedVoiceId),
        dateCreated: drift.Value(DateTime.now()),
        sortOrder: drift.Value(0), // Will be adjusted based on existing photos
      );

      // 4. Save to database
      await photosProvider.addPhoto(photo);

      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();
        // Return to main screen
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } catch (e) {
      // Close loading dialog
      if (mounted) {
        Navigator.of(context).pop();
        _showErrorDialog('Failed to save photo: $e');
      }
    }
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
