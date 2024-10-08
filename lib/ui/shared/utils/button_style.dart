import 'package:flutter/material.dart';

ButtonStyle getContrastElevatedButtonStyle(BuildContext context) {
  return ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.onPrimary,
    foregroundColor: Theme.of(context).colorScheme.primary,
    textStyle: Theme.of(context).primaryTextTheme.titleMedium,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
}
