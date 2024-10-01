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
            child: Text('Skip',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                'Invite Collaborators',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Search for your friends and add them to your workspace to start collaborating.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20.0),

              // Invite friends bar
              const InviteFriendsBar(),
              const SizedBox(height: 20.0),

              // Invite friends description
              Text(
                'Note that your friends will receive an invitation to join your workspace. You can also invite them later. Currently, you can only invite friends who are already on the platform.',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.4)),
                maxLines: 4,
                softWrap: true,
              ),
            ]),
      ),
    );
  }
}
