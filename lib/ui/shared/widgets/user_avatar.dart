import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../screens.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
    this.user, {
    super.key,
    this.size = 40.0,
    this.borderRadius = 10.0,
    this.isTappable = true,
  });

  final User user;
  final double size;
  final double borderRadius;
  final bool isTappable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isTappable ? () => _viewProfile(context) : null,
      child: SizedBox(
        height: size,
        width: size,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(
            user.avatarUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _viewProfile(BuildContext context) {
    Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: user);
  }
}
