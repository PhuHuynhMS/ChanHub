import 'package:flutter/material.dart';

import '../../screens.dart';

class WorkspaceGetStarted extends StatelessWidget {
  const WorkspaceGetStarted({super.key});

  void _createWorkspace(BuildContext context) {
    Navigator.of(context).pushNamed(CreateWorkspaceScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Get started
              Text(
                'Get started with ChanHub',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Image.asset('assets/images/get_started_bg.jpg'),
              const Text(
                'We provides a new way to communicate with everyone you work with. It\'s faster and better organized than email - and it\'s free to try.',
                textAlign: TextAlign.justify,
              ),

              // Create workspace action
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _createWorkspace(context),
                  child: const Text('Create workspace'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
