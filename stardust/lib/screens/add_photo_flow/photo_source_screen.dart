import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'label_input_screen.dart';

/// First step in add photo flow: choose photo source (camera or library)
class PhotoSourceScreen extends StatelessWidget {
  PhotoSourceScreen({super.key});

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Add Photo'),
        previousPageTitle: 'Back',
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Choose a photo source',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Take Photo button
              _buildSourceButton(
                context,
                icon: CupertinoIcons.camera_fill,
                label: 'Take Photo',
                onPressed: () => _handleTakePhoto(context),
              ),
              
              const SizedBox(height: 24),
              
              // Choose from Library button
              _buildSourceButton(
                context,
                icon: CupertinoIcons.photo_fill,
                label: 'Choose from Library',
                onPressed: () => _handleChooseFromLibrary(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSourceButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey6,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: CupertinoColors.systemGrey4,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: CupertinoColors.activeBlue,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: CupertinoColors.label,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleTakePhoto(BuildContext context) async {
    // Request camera permission
    final status = await Permission.camera.request();
    
    if (!status.isGranted) {
      if (context.mounted) {
        _showPermissionDeniedDialog(context, 'Camera');
      }
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85, // Balance quality and file size
      );

      if (image != null && context.mounted) {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => LabelInputScreen(imageFile: File(image.path)),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, 'Failed to take photo: $e');
      }
    }
  }

  Future<void> _handleChooseFromLibrary(BuildContext context) async {
    // Request photos permission
    final status = await Permission.photos.request();
    
    if (!status.isGranted) {
      if (context.mounted) {
        _showPermissionDeniedDialog(context, 'Photos');
      }
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image != null && context.mounted) {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => LabelInputScreen(imageFile: File(image.path)),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, 'Failed to choose photo: $e');
      }
    }
  }

  void _showPermissionDeniedDialog(BuildContext context, String permissionType) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('$permissionType Permission Required'),
        content: Text(
          'Please enable $permissionType access in Settings to add photos.',
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

  void _showErrorDialog(BuildContext context, String message) {
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
