import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';

class SettingsForm extends StatelessWidget {
  const SettingsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Change theme
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          title: const Text('Dark Mode'),
          trailing: Transform.scale(
            scale: 0.7,
            child: Switch(
              value: context.watch<ThemeManager>().isDarkMode,
              onChanged: (value) => _toggleDarkMode(context),
            ),
          ),
        ),

        // Logout
        ListTile(
          contentPadding: const EdgeInsets.only(
            left: 10.0,
            right: 25.0,
          ),
          title: const Text('Logout'),
          trailing: Icon(
            Icons.exit_to_app,
            color: Theme.of(context).colorScheme.error,
          ),
          onTap: () => _logout(context),
        ),
      ],
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthManager>().logout();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _toggleDarkMode(BuildContext context) {
    context.read<ThemeManager>().toggleDarkMode();
  }
}
