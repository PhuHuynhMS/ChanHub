import 'package:flutter/material.dart';

import '../../screens.dart';
import '../../shared/widgets/index.dart';
import './index.dart';

class LoginForm extends StatelessWidget {
  static const String routeName = '/login';

  const LoginForm({
    super.key,
    this.toggleLoginRegister,
  });

  final void Function()? toggleLoginRegister;

  void _navigateToWorkspace(BuildContext context) {
    Navigator.of(context).pushNamed(WorkspaceScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            // Background image
            const ShadowedTitle('Login'),
            const Text('Enter your email and password to login'),
            const SizedBox(height: 20),

            // Email field
            const BlockTextField(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            const SizedBox(height: 10),

            // Password field
            const BlockTextField(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            const SizedBox(height: 10),

            // Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Login'),
                onPressed: () => _navigateToWorkspace(context),
              ),
            ),

            // Register button (With text)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Don\'t have an account?'),
                TextButton(
                  onPressed: toggleLoginRegister,
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
