import 'package:flutter/foundation.dart';

import '../models/index.dart';
import '../services/index.dart';

class AuthManager with ChangeNotifier {
  late final AuthService _authService;
  User? _loggedInUser;

  AuthManager() {
    _authService = AuthService(onAuthChanged: (User? user) {
      _loggedInUser = user;
      notifyListeners();
    });
  }

  bool get isLoggedIn {
    return _loggedInUser != null;
  }

  User? get loggedInUser {
    return _loggedInUser;
  }

  Future<bool> signup({
    required String email,
    required String password,
    required String username,
    String? jobTitle,
    String? fullname,
  }) async {
    return _authService.signup(
      email: email,
      password: password,
      username: username,
      jobTitle: jobTitle,
      fullname: fullname,
    );
  }

  Future<User> login({
    required String email,
    required String password,
  }) async {
    return _authService.login(email: email, password: password);
  }

  Future<void> tryAutoLogin() async {
    final user = await _authService.getUserFromStore();
    if (user != null) {
      _loggedInUser = user;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _loggedInUser = null;
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await _authService.requestPasswordReset(email);
  }

  Future<void> updateUserInfo(User newUserInfo) async {
    await _authService.updateUserInfo(newUserInfo);
    notifyListeners();
  }

  Future<void> updatePassword(Map<String, dynamic> passwords) async {
    await _authService.updatePassword(passwords, _loggedInUser!.email);
    _loggedInUser = _loggedInUser!.copyWith(password: passwords['password']);
    notifyListeners();
  }
}
