import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';

class ChannelDescription extends StatelessWidget {
  const ChannelDescription(
    this.channel, {
    super.key,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Channel title
            Text(
              '# ${channel.name}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10.0),

            // Channel creator
            Text.rich(
              TextSpan(
                style: Theme.of(context).textTheme.bodySmall,
                children: [
                  createUserTag(user: channel.creator!),
                  TextSpan(
                    text:
                        ' created this channel on ${channel.createdAt!.day}/${channel.createdAt!.month}/${channel.createdAt!.year}. '
                        'This is a very begining of the #${channel.name} channel.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10.0),

            // Channel description
            Text(
              channel.description ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
