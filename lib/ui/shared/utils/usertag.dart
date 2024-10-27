import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../models/user.dart';

TextSpan createUserTag({required User user, TextStyle? style}) {
  return TextSpan(
    text: '@${user.username}',
    style: style ??
        const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
    recognizer: TapGestureRecognizer()
      ..onTap = () {
        // TODO: Navigate to user profile screen
        print('User tag tapped');
      },
  );
}
