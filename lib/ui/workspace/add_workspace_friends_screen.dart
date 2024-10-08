import 'package:flutter/material.dart';

import '../shared/widgets/index.dart';

class AddWorkspaceFriendsScreen extends StatelessWidget {
  static const String routeName = '/add-workspace-friends';

  const AddWorkspaceFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Collaborators'),
        actions: [
          TextButton(
            onPressed: () {
              //TODO: Next screen
            },
            child: Text(
              'Skip',
              style: Theme.of(context).primaryTextTheme.titleSmall,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Invite Collaborators',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Search for and add collaborators to your workspace',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  const InviteFriendsBar()
                ]),
          ),
        ),
      ),
    );
  }
}
