import './local_storage_service.dart';

class OnboardingService {
  static String localCompleteOnboardingKey = 'complete_onboarding';

  Future<void> completeOnboarding() async {
    final localStorageService = await LocalStorageService.getInstance();
    localStorageService.set(localCompleteOnboardingKey, true);
  }

  Future<bool> isFirstTime() async {
    final localStorageService = await LocalStorageService.getInstance();
    return localStorageService.get(localCompleteOnboardingKey) == null;
  }

  // TODO: For testing purposes (remove in production)
  Future<void> resetOnboarding() async {
    final localStorageService = await LocalStorageService.getInstance();
    localStorageService.set(localCompleteOnboardingKey, null);
  }
}
