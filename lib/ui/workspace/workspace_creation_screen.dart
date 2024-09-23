import 'package:flutter/material.dart';

class WorkspaceCreationScreen extends StatelessWidget {
  static const String routeName = '/workspace_creation_screen';

  const WorkspaceCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create workspace'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'What\'s is the name of your company or team?',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'This will be the name of your workspace',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(child: WorkspaceCreationForm()),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Chấp nhận chính sách của ChanHub',
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.6,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Next'),
            ),
          )
        ],
      ),
    );
  }
}

class WorkspaceCreationForm extends StatelessWidget {
  const WorkspaceCreationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Name it',
        ),
      ),
    );
  }
}
