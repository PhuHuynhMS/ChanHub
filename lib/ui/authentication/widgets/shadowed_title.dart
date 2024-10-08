import 'package:flutter/material.dart';

class ShadowedTitle extends StatelessWidget {
  const ShadowedTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
        shadows: <Shadow>[
          Shadow(
            color: Theme.of(context).colorScheme.onPrimary,
            blurRadius: 4.0,
            offset: const Offset(1.0, 1.0),
          ),
        ],
      ),
    );
  }
}
