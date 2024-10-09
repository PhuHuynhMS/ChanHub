import 'package:flutter/material.dart';

import '../../../models/index.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({required this.user, super.key});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      width: double.infinity,
      height: 90.0,
      child: Column(
        children: [
          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                //TODO: Save info
              },
              child: const Text('Save'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),

          // Logout button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surface),
              ),
              onPressed: () {
                //TODO: Logout
              },
              child: Text(
                'Logout',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
