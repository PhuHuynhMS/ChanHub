import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/widgets/index.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
    this.user, {
    super.key,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    final User? loggedInUser = context.read<AuthManager>().loggedInUser;
    final bool isMyProfile = loggedInUser?.id == user.id;

    return Stack(
      children: [
        UserAvatar(
          user,
          size: 140,
          borderRadius: 70,
          isTappable: false,
        ),
        if (isMyProfile) ...[
          // Edit button
          Positioned(
            right: -5,
            bottom: -5,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
              icon: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ),
        ],
      ],
    );
  }
}
