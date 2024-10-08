import 'package:flutter/material.dart';

import '../../screens.dart';
import '../../shared/widgets/index.dart';
import './index.dart';

class RegisterForm extends StatelessWidget {
  static const String routeName = '/register';

  const RegisterForm({
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
            const ShadowedTitle('Register'),
            const Text('Let\'s get you started'),
            const SizedBox(height: 20),

            // Email field
            const BlockTextField(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            const SizedBox(height: 10),

            // Username field
            const BlockTextField(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person_pin),
            ),
            const SizedBox(height: 10),

            // Full name field
            const BlockTextField(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
            ),
            const SizedBox(height: 10),

            // Password field
            const BlockTextField(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            const SizedBox(height: 10),

            // Confirm password field
            const BlockTextField(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock),
            ),
            const SizedBox(height: 10),

            // Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Register'),
                onPressed: () => _navigateToWorkspace(context),
              ),
            ),

            // Login button (With text)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have an account?'),
                TextButton(
                  onPressed: toggleLoginRegister,
                  child: const Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
