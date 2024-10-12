import 'package:flutter/material.dart';

class ProfileManager with ChangeNotifier {
  late bool enabled = false;

  void initFormState(bool value) {
    enabled = false;
  }

  void unlockedForm() {
    enabled = true;
    notifyListeners();
  }
}
