import 'package:flutter/material.dart';

import '../services/index.dart';
import '../models/index.dart';

class UsersManager with ChangeNotifier {
  final UserService _userService = UserService();

  List<User> _users = [];

  Future<void> fetchUsers() async {
    _users = await _userService.fetchAllUsers();
    notifyListeners();
  }

  List<User> getAll() {
    return [..._users];
  }

  Future<List<User>> searchUsers(String query) async {
    return await _userService.searchUsers(query);
  }
}
