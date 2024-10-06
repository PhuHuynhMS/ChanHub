import 'package:flutter/material.dart';

import '../../screens.dart';
import '../../shared/widgets/index.dart';

class RegisterForm extends StatelessWidget {
  static const String routeName = '/register';

  const RegisterForm({
    super.key,
    this.toggleLoginRegister,
  });

  final void Function()? toggleLoginRegister;

  void navigateToWorkspace(BuildContext context) {
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
            Text(
              'Register now',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
                shadows: <Shadow>[
                  Shadow(
                    color: Theme.of(context).colorScheme.onPrimary,
                    blurRadius: 4.0,
                    offset: const Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
            const Text('Let\'s get you started'),
            const SizedBox(height: 20),

            // Email field
            BlockTextField(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),

            // Username field
            BlockTextField(
              labelText: 'Username',
              prefixIcon: Icon(Icons.person_pin,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),

            // Full name field
            BlockTextField(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),

            // Password field
            BlockTextField(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),

            // Confirm password field
            BlockTextField(
              labelText: 'Confirm Password',
              prefixIcon: Icon(Icons.lock,
                  color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 10),

            // Login button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Register',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                onPressed: () => navigateToWorkspace(context),
              ),
            ),

            // Login button (With text)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have an account?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                TextButton(
                  onPressed: toggleLoginRegister,
                  child: Text(
                    'Login',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
