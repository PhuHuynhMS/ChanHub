import 'package:flutter/material.dart';

InputDecoration underlineInputDecoration(
  BuildContext context,
  String hintText, {
  Widget? prefixIcon,
}) {
  return InputDecoration(
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        width: 0.5,
      ),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary,
        width: 0.5,
      ),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 0.5,
      ),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.error,
        width: 0.5,
      ),
    ),
    hintText: hintText,
    hintStyle: Theme.of(context).textTheme.labelMedium,
    prefixIcon: prefixIcon,
  );
}

InputDecoration borderlessInputDecoration(
  BuildContext context,
  String hintText,
) {
  return InputDecoration(
    hintText: 'Type a message',
    hintStyle: Theme.of(context).textTheme.labelMedium,
    border: InputBorder.none,
    contentPadding: const EdgeInsets.all(10.0),
  );
}

InputDecoration outlinedInputDecoration(
  BuildContext context,
  String hintText, {
  Widget? prefixIcon,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        width: 0.5,
      ),
    ),
    hintText: hintText,
    hintStyle: Theme.of(context).textTheme.labelMedium,
    prefixIcon: prefixIcon,
  );
}
