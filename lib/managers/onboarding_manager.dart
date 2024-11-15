import 'package:flutter/foundation.dart';

import '../services/index.dart';

class OnboardingManager with ChangeNotifier {
  late OnboardingService _onboardingService;
  late bool _isFirstTime;
  late bool _isLoading;

  OnboardingManager() {
    _onboardingService = OnboardingService();
    _isLoading = true;
  }

  Future<void> init() async {
    _isFirstTime = await _onboardingService.isFirstTime();
    _isLoading = false;
    notifyListeners();
  }

  bool get isFirstTime => _isFirstTime;

  bool get isLoading => _isLoading;

  Future<void> completeOnboarding() async {
    await _onboardingService.completeOnboarding();
    _isFirstTime = false;
    notifyListeners();
  }

  // For testing purposes
  Future<void> resetOnboarding() async {
    await _onboardingService.resetOnboarding();
    _isFirstTime = true;
    notifyListeners();
  }
}
