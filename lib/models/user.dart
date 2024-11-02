import 'dart:io';

import '../ui/shared/extensions/index.dart';
import '../common/constants.dart';

class User {
  final String id;
  final String fullname;
  final String username;
  final String email;
  String? jobTitle;
  String? password;
  File? avatar;
  final String avatarUrl;

  User({
    required this.id,
    required this.fullname,
    required this.username,
    required this.email,
    this.jobTitle,
    this.avatar,
    this.avatarUrl = defaultUserAvatarUrl,
    this.password,
  });

  User copyWith({
    String? id,
    String? fullname,
    String? jobTitle,
    String? username,
    String? email,
    String? password,
    File? avatar,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      jobTitle: jobTitle ?? this.jobTitle,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      avatar: avatar ?? this.avatar,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return username;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      avatarUrl: json.getImageUrl('avatar') ?? defaultUserAvatarUrl,
      fullname: json['fullname'],
      jobTitle: json['jobTitle'],
      username: json['username'],
      email: json['email'],
    );
  }
}
