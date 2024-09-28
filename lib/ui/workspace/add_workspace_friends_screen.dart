import 'package:flutter/material.dart';

import '../shared/widget/invite_friends_bar.dart';

class AddWorkspaceFriendsScreen extends StatelessWidget {
  static const String routeName = '/add-workspace-friends';

  const AddWorkspaceFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              //TODO: Next screen
            },
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
            child: Text('Skip',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Invite Collaborators',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                'Search for and add collaborators to your workspace',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 20.0,
              ),
              const InviteFriendsBar()
            ]),
      ),
    );
  }
}
