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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(height: 20.0),
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text(
                      confirmText,
                      style: Theme.of(context).textTheme.titleMedium,
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(height: 20.0),
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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  if (confirmText != null)
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        confirmText,
                        style: Theme.of(context).textTheme.titleMedium,
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
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Divider(height: 20.0),
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

Future<DateTime?> showDateTimePicker(BuildContext context) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (pickedDate == null) {
    return null;
  }

  // Check if the widget is still mounted
  if (!context.mounted) {
    return null;
  }

  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime == null) {
    return null;
  }

  return DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );
}
