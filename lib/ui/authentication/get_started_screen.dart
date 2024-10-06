import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens.dart';

class GetStartedScreen extends StatelessWidget {
  static const String routeName = '/get-started';

  const GetStartedScreen({super.key});

  void navigateToRegister(BuildContext context) {
    Navigator.of(context)
        .pushNamed(LoginOrRegisterScreen.routeName, arguments: false);
  }

  void navigateToLogin(BuildContext context) {
    Navigator.of(context)
        .pushNamed(LoginOrRegisterScreen.routeName, arguments: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/svg/get_started.svg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'ChanHub',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Connect with your team now!',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 20),

                  // Get Started button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      onPressed: () => navigateToLogin(context),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Sign In button
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      child: const Text('Register'),
                      onPressed: () => navigateToRegister(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
