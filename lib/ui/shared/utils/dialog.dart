import 'package:flutter/material.dart';

Future<bool> showConfirmDialog({
  required BuildContext context,
  String title = 'Confirm',
  String content = 'Are you sure to continue?',
  String confirmText = 'Yes',
  String cancelText = 'No',
}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 10.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
              const SizedBox(height: 10.0),

              // Content
              Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20.0),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      cancelText,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      confirmText,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> showInfoDialog({
  required BuildContext context,
  String title = 'Information',
  List<Widget> children = const <Widget>[],
  Widget? content,
  String cancelText = 'Close',
  String? confirmText,
}) async {
  assert(
      (content != null && children.isEmpty) ||
          (content == null && children.isNotEmpty),
      'Either content or children must be provided');
  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 10.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
              const SizedBox(height: 10.0),

              // Content
              Flexible(
                child: SingleChildScrollView(
                    child: content ??
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children,
                        )),
              ),

              // Action button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      cancelText,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                  if (confirmText != null)
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        confirmText,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<bool> showInputDialog({
  required BuildContext context,
  String title = 'Information',
  List<Widget> children = const <Widget>[],
  Widget? content,
}) async {
  assert(
      (content != null && children.isEmpty) ||
          (content == null && children.isNotEmpty),
      'Either content or children must be provided');
  return await showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 20.0,
            bottom: 10.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              ),
              const SizedBox(height: 10.0),

              // Content
              Flexible(
                child: SingleChildScrollView(
                    child: content ??
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children,
                        )),
              ),
            ],
          ),
        ),
      );
    },
  );
}
