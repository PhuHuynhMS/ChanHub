import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../../../models/user.dart';

TextSpan createUserTag({required User user, required TextStyle style}) {
  return TextSpan(
    text: '@${user.userName}',
    style: style,
    recognizer: TapGestureRecognizer()
      ..onTap = () {
        // TODO: Navigate to user profile screen
        print('User tag tapped');
      },
  );
}
