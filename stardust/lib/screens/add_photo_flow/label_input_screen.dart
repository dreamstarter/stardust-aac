import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'audio_setup_screen.dart';

/// Second step in add photo flow: enter label for the photo
class LabelInputScreen extends StatefulWidget {
  final File imageFile;

  const LabelInputScreen({
    super.key,
    required this.imageFile,
  });

  @override
  State<LabelInputScreen> createState() => _LabelInputScreenState();
}

class _LabelInputScreenState extends State<LabelInputScreen> {
  final TextEditingController _labelController = TextEditingController();
  bool _canProceed = false;

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Add Label'),
        previousPageTitle: 'Back',
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              
              // Photo preview
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    widget.imageFile,
                    height: 280,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Instructions
              const Text(
                'What should we call this?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 8),
              
              const Text(
                'One word works best',
                style: TextStyle(
                  fontSize: 16,
                  color: CupertinoColors.systemGrey,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 24),
              
              // Label input field
              CupertinoTextField(
                controller: _labelController,
                placeholder: 'e.g., home, mom, water',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: CupertinoColors.systemGrey4,
                    width: 1,
                  ),
                ),
                autofocus: true,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                onChanged: _handleLabelChanged,
              ),
              
              const SizedBox(height: 32),
              
              // Next button
              CupertinoButton.filled(
                onPressed: _canProceed ? _handleNext : null,
                child: const Text(
                  'Next',
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

  void _handleLabelChanged(String value) {
    setState(() {
      _canProceed = value.trim().isNotEmpty;
    });
  }

  void _handleNext() {
    final label = _labelController.text.trim();
    if (label.isEmpty) return;

    // Navigate to audio setup screen
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => AudioSetupScreen(
          imageFile: widget.imageFile,
          label: label,
        ),
      ),
    );
  }
}
