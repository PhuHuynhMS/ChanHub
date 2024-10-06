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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Get started
            Text(
              'Get started with ChanHub',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Image.asset('assets/images/get_started_bg.jpg'),
            Text(
              'We provides a new way to communicate with everyone you work with. It\'s faster and better organized than email - and it\'s free to try.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 10.0),

            // Create workspace action
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => createWorkspace(context),
                child: const Text(
                  'Create workspace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
