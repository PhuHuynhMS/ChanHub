import 'package:flutter/material.dart';

class ProfileScreenManager with ChangeNotifier {
  late bool enabled = false;

  void initFormState(bool value) {
    enabled = false;
  }

  void unlockedForm() {
    enabled = true;
    notifyListeners();
  }
}
