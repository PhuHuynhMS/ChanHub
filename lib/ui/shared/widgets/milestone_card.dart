import 'package:flutter/material.dart';

class MilestoneCard extends StatelessWidget {
  const MilestoneCard({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 1.0,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1.0,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ],
      ),
    );
  }
}
