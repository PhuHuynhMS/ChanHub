import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/widgets/index.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.isMyProfile = false,
  });

  final bool isMyProfile;

  @override
  Widget build(BuildContext context) {
    final User user = User(
      id: '1',
      fullname: 'John Doe',
      jobTitle: 'Software Engineer',
      username: 'johndoe',
      email: 'john@gmail.com',
      avatarUrl: 'https://picsum.photos/420/380',
    );

    return Column(
      children: [
        Stack(
          children: [
            UserAvatar(
              user,
              size: 140,
              borderRadius: 70,
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
        ),
        const SizedBox(height: 10),
        Text(user.fullname, style: Theme.of(context).textTheme.titleLarge),
        Text(
          user.jobTitle ?? '',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
