import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile_screen_manager.dart';

import '../../../models/index.dart';
import '../../shared/widgets/index.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserAvatar(
          user,
          size: 140,
          borderRadius: 70,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(user.jobTitle),
        Text(
          user.fullName,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        Selector<ProfileScreenManager, bool>(
            selector: (_, manager) => manager.enabled,
            builder: (_, enabled, __) {
              return TextButton(
                onPressed: () {
                  if (enabled == false) {
                    context.read<ProfileScreenManager>().unlockedForm();
                  }
                },
                style: const ButtonStyle(
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                ),
                child: Text(
                  'Change Profile',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
