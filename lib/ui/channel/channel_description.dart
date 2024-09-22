import 'package:flutter/material.dart';

import '../../models/channel.dart';
import '../shared/utils/usertag.dart';

class ChannelDescription extends StatelessWidget {
  const ChannelDescription(
    this.channel, {
    super.key,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Channel title
            Text(
              '# ${channel.name}',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 10.0),

            // Channel creator
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  createUserTag(
                    user: channel.creator,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  TextSpan(
                    text:
                        ' created this channel on ${channel.createdAt.day}/${channel.createdAt.month}/${channel.createdAt.year}. '
                        'This is a very begining of the #${channel.name} channel.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),

            // Channel description
            Text(
              channel.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 10.0),

            // Channel actions
            BlockButton(
              icon: Icons.person_add,
              text: 'Add members',
              onPressed: () {
                print('Add members');
              },
            ),
            BlockButton(
              icon: Icons.edit,
              text: 'Edit channel',
              onPressed: () {
                print('Edit channel');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BlockButton extends StatelessWidget {
  const BlockButton({
    super.key,
    required this.icon,
    required this.text,
    this.onPressed,
  });

  final IconData icon;
  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Decorative divider
        Divider(
          color: Theme.of(context).colorScheme.primary,
          thickness: 1.0,
          height: 0,
          indent: 80.0,
          endIndent: 0.0,
        ),

        // Button
        TextButton(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
            ),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            ),
          ),
          onPressed: onPressed,
          child: SizedBox(
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 40.0),
                  child: Icon(
                    icon,
                    size: Theme.of(context).textTheme.bodyLarge?.fontSize,
                  ),
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
