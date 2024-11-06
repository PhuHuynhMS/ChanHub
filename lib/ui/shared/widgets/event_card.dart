import 'package:flutter/material.dart';

import '../../../models/index.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.creator,
    required this.createdAt,
    this.content,
  });

  final User creator;
  final DateTime createdAt;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.fiber_new_sharp,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(width: 5.0),
          Text(
            '$content',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}
