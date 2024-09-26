import 'package:flutter/material.dart';

class CustomSlideTransition extends PageRouteBuilder {
  final Widget page;

  CustomSlideTransition({
    super.settings,
    required this.page,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutSine;

            Animatable<Offset> tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(
              curve: curve,
            ));

            Animation<Offset> offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
}
