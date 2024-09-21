import 'package:flutter/material.dart';

import 'workspace_creation_screen.dart';
import 'workspace_screen.dart';
import 'workspaces_manager.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to ChanHub!',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            'We\'re excited to help you bla bla bla...',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, WorkspaceCreationScreen.routeName);
            },
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(5.0),
              textStyle:
                  WidgetStatePropertyAll(Theme.of(context).textTheme.bodyLarge),
              backgroundColor:
                  WidgetStatePropertyAll(Theme.of(context).primaryColor),
            ),
            child: Text(
              'Create workspace',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement join workspace
              Navigator.pushReplacementNamed(
                context,
                WorkspaceScreen.routeName,
                arguments: WorkspacesManager().workspaces.first,
              );
            },
            style: const ButtonStyle(
              elevation: WidgetStatePropertyAll(5.0),
            ),
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}
