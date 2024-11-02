import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget getLoadingAnimation(BuildContext context) {
  return Center(
    child: LoadingAnimationWidget.staggeredDotsWave(
      size: 50.0,
      color: Theme.of(context).colorScheme.primary,
    ),
  );
}
