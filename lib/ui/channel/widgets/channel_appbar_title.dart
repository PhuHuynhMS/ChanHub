import 'package:flutter/material.dart';

import '../../../common/enums.dart';
import '../../../models/channel.dart';
import '../../shared/utils/index.dart';

class ChannelAppBarTitle extends StatelessWidget {
  const ChannelAppBarTitle(
    this.channel, {
    super.key,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(getChannelIcon(channel.privacy)),
            Text(' ${channel.name}'),
          ],
        ),
        Text(
          channel.privacy == ChannelPrivacy.private
              ? '${channel.memberCount} members'
              : 'Everyone can join',
          style: Theme.of(context).primaryTextTheme.titleSmall,
        ),
      ],
    );
  }
}
