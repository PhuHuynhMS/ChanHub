import 'package:flutter/material.dart';

import './create_workspace_screen.dart';

class WorkspaceGetStarted extends StatelessWidget {
  static const String routeName = '/workspace-get-started';
  const WorkspaceGetStarted({super.key});

  void createWorkspace(BuildContext context) {
    Navigator.of(context).pushNamed(CreateWorkspaceScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Welcome message
          Text(
            'Get started with ChanHub',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'It\'s a new way to communicate with everyone you work with. It\'s faster, better organized, and more secure than email — and it\'s free to try.',
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 10.0),

          // Create workspace action
          ElevatedButton(
            onPressed: () => createWorkspace(context),
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
        ],
      ),
    );
  }
}
