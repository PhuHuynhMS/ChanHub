import 'package:flutter/material.dart';

import '../shared/widgets/index.dart';
import '../screens.dart';

class AddWorkspaceMembersScreen extends StatelessWidget {
  static const String routeName = '/workspace/members/add';

  const AddWorkspaceMembersScreen({super.key});

  void _navigateToWorkspaceScreen(BuildContext context) {
    Navigator.of(context).pushNamed(WorkspaceScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Collaborators'),
        actions: [
          TextButton(
            onPressed: () => _navigateToWorkspaceScreen(context),
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
                const InviteMembersBar(),

                // Invite button
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _navigateToWorkspaceScreen(context),
                    child: const Text('Invite'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
