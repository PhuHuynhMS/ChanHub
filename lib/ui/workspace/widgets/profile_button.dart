import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../screens.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.user,
  });

  final User user;

  void goToProfilePage(BuildContext context) {
    Navigator.of(context).pushNamed(
      ProfileScreen.routeName,
      arguments: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToProfilePage(context),
      child: CircleAvatar(
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
    );
  }
}
