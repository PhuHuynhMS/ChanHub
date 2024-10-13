import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shared/utils/index.dart';
import '../screens.dart';

class GetStartedScreen extends StatelessWidget {
  static const String routeName = '/get-started';

  const GetStartedScreen({super.key});

  void _navigateToRegister(BuildContext context) {
    Navigator.of(context)
        .pushNamed(LoginOrRegisterScreen.routeName, arguments: false);
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context)
        .pushNamed(LoginOrRegisterScreen.routeName, arguments: true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Decorative background image
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/svg/get_started.svg',
            fit: BoxFit.cover,
          ),
        ),

        // Content
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('ChanHub',
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 10),
                Text(
                  'Connect with your team now!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 20),

                // Get Started button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    child: const Text('Get Started'),
                    onPressed: () => _navigateToRegister(context),
                  ),
                ),
                const SizedBox(height: 10),

                // Sign In button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: getContrastElevatedButtonStyle(context),
                    child: const Text('Login'),
                    onPressed: () => _navigateToLogin(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
