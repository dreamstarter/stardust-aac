import 'package:flutter/foundation.dart';

/// Manages edit mode state for the communication board
class EditModeProvider with ChangeNotifier {
  bool _isEditMode = false;

  bool get isEditMode => _isEditMode;

  void toggleEditMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }

  void setEditMode(bool value) {
    if (_isEditMode != value) {
      _isEditMode = value;
      notifyListeners();
    }
  }

  void exitEditMode() {
    setEditMode(false);
  }
}
