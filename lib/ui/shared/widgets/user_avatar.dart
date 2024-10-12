import 'package:flutter/material.dart';

import '../../../models/user.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
    this.user, {
    super.key,
    this.size = 40.0,
    this.borderRadius = 10.0,
  });

  final User user;
  final double size;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.network(
          user.avatarUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
