class User {
  final String id;
  final String fullName;
  final String userName;
  final String email;
  String? password;
  final String avatarUrl;

  User({
    required this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.avatarUrl,
    this.password,
  });

  User copyWith({
    String? id,
    String? fullName,
    String? userName,
    String? email,
    String? password,
    String? avatarUrl,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  String toString() {
    return userName;
  }
}
