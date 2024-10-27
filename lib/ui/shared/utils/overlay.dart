import 'package:flutter/material.dart';

import './index.dart';

final OverlayEntry loadingOverlay = OverlayEntry(
  builder: (context) => Positioned(
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    child: Material(
      color: Colors.black.withOpacity(0.5),
      child: getLoadingAnimation(context),
    ),
  ),
);

void showLoadingOverlay(BuildContext context) {
  Overlay.of(context).insert(loadingOverlay);
}

void hideLoadingOverlay(BuildContext context) {
  loadingOverlay.remove();
}
 