import 'dart:async';
import 'package:flutter/material.dart';

import '../screens.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize the app
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(OnboardingScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Center(
        child: _buildLogo(),
      ),
    );
  }

  Widget _buildLogo() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.tertiary,
          ],
        ).createShader(bounds);
      },
      child: Text(
        "ChanHub",
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
