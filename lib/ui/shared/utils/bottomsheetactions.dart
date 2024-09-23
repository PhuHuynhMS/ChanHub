import 'package:flutter/material.dart';

void showModalBottomSheetActions({
  required BuildContext context,
  Widget? header,
  String? title,
  Widget? body,
}) {
  assert((title != null) ^ (header != null),
      'Either title or header must be provided, but not both.');

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) => Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Wrap(
        children: <Widget>[
          // Header
          if (header != null) header,
          if (title != null) DefaultBottomSheetActionHeader(title),

          Divider(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            height: 0.0,
          ),
          // Body
          if (body != null) body,
        ],
      ),
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    ),
  );
}

class DefaultBottomSheetActionHeader extends StatelessWidget {
  const DefaultBottomSheetActionHeader(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}