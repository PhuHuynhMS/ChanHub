import 'package:flutter/material.dart';

import './shared/utils/index.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getLoadingAnimation(context),
    );
  }
}
