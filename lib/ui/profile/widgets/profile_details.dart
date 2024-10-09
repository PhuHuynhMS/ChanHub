import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../profile_screen_manager.dart';

import '../../../models/index.dart';
import '../../shared/widgets/index.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({required this.user, this.enabled = false, super.key});

  final User user;
  final bool enabled;

  void _navigateToChangePasswordScreen(BuildContext context) {
    Navigator.pushNamed(context, '/profile/change-password');
  }

  @override
  Widget build(BuildContext context) {
    final enabled = context
        .select<ProfileScreenManager, bool>((manager) => manager.enabled);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full name field
        BlockTextField(
            labelText: 'Full Name',
            initialValue: user.fullName,
            enabled: enabled,
            prefixIcon: Icon(Icons.person,
                color: enabled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            suffixIcon: enabled
                ? Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(Icons.lock,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5))),
        const SizedBox(
          height: 10,
        ),
        // Job title field
        BlockTextField(
            labelText: 'Job Title',
            initialValue: user.jobTitle,
            enabled: enabled,
            prefixIcon: Icon(Icons.work,
                color: enabled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            suffixIcon: enabled
                ? Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(Icons.lock,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5))),
        const SizedBox(
          height: 10,
        ),

        // Email field
        BlockTextField(
            labelText: 'Email',
            initialValue: user.email,
            enabled: enabled,
            prefixIcon: Icon(Icons.email,
                color: enabled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            suffixIcon: enabled
                ? Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(Icons.lock,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5))),
        const SizedBox(
          height: 10,
        ),

        // Username field
        BlockTextField(
            labelText: 'Username',
            initialValue: user.userName,
            enabled: enabled,
            prefixIcon: Icon(Icons.person_pin,
                color: enabled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            suffixIcon: enabled
                ? Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Icon(Icons.lock,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5))),
        const SizedBox(
          height: 10,
        ),

        //Change password
        TextButton(
          onPressed: () {
            _navigateToChangePasswordScreen(context);
          },
          child: const Text(
            'Change Password',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}
