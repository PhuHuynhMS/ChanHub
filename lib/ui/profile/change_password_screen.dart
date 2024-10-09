import 'package:flutter/material.dart';

import '../shared/widgets/index.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = '/profile/change-password';

  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const BlockTextField(
              labelText: 'Current Password',
            ),
            const SizedBox(
              height: 10.0,
            ),
            const BlockTextField(
              labelText: 'New Password',
            ),
            const SizedBox(
              height: 10.0,
            ),
            const BlockTextField(
              labelText: 'Confirm Password',
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  //TODO: Update password
                },
                child: const Text('Change Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
