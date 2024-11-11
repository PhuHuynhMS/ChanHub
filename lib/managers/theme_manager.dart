import 'package:flutter/material.dart';

import '../themes/chanhub_theme.dart' as themes;
import '../services/index.dart';

class ThemeManager with ChangeNotifier {
  final LocalStorageService _localStorageService = LocalStorageService();

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeManager() {
    _isDarkMode = _localStorageService.get('isDarkMode') ?? false;
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _localStorageService.set('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode ? themes.darkTheme : themes.lightTheme;
  }
}
