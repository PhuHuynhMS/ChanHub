import 'package:flutter/material.dart';

import '../../../themes/chanhub_theme.dart';

void showSuccessSnackBar({
  required BuildContext context,
  required String message,
  IconData prefixIcon = Icons.check_circle,
  IconData? suffixIcon,
  Widget action = const SizedBox.shrink(),
  double duration = 2.0,
  Color? backgroundColor,
  Color? textColor,
  Color iconColor = ChanHubColors.primary,
}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Row(
          children: [
            Icon(prefixIcon, color: iconColor),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor,
                    ),
              ),
            ),
            action,
            if (suffixIcon != null) ...[
              const SizedBox(width: 10.0),
              Icon(suffixIcon, color: iconColor),
            ],
          ],
        ),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.surface,
        duration: Duration(milliseconds: (duration * 1000).toInt()),
      ),
    );
}

void showErrorSnackBar({
  required BuildContext context,
  required String message,
  IconData prefixIcon = Icons.error,
  IconData? suffixIcon,
  Widget action = const SizedBox.shrink(),
  double duration = 2.0,
  Color? backgroundColor,
  Color? textColor,
  Color iconColor = ChanHubColors.error,
}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Row(
          children: [
            Icon(prefixIcon, color: iconColor),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor,
                    ),
              ),
            ),
            action,
            if (suffixIcon != null) ...[
              const SizedBox(width: 10.0),
              Icon(suffixIcon, color: iconColor),
            ],
          ],
        ),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.surface,
        duration: Duration(milliseconds: (duration * 1000).toInt()),
      ),
    );
}

void showInfoSnackBar({
  required BuildContext context,
  required String message,
  IconData prefixIcon = Icons.info,
  IconData? suffixIcon,
  Widget action = const SizedBox.shrink(),
  double duration = 2.0,
  Color? backgroundColor,
  Color? textColor,
  Color iconColor = ChanHubColors.secondary,
}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        elevation: 0.0,
        content: Row(
          children: [
            Icon(prefixIcon, color: iconColor),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: textColor,
                    ),
              ),
            ),
            action,
            if (suffixIcon != null) ...[
              const SizedBox(width: 10.0),
              Icon(suffixIcon, color: iconColor),
            ],
          ],
        ),
        backgroundColor:
            backgroundColor ?? Theme.of(context).colorScheme.surface,
        duration: Duration(milliseconds: (duration * 1000).toInt()),
      ),
    );
}
