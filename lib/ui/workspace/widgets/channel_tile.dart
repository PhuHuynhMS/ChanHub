import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/enums.dart';
import '../../../common/constants.dart';
import '../../../managers/index.dart';
import '../../../models/channel.dart';
import '../../shared/utils/index.dart';
import '../../screens.dart';

class ChannelTile extends StatelessWidget {
  const ChannelTile(
    this.channel, {
    super.key,
  });

  final Channel channel;

  void _navigateToChannel(BuildContext context, Channel channel) {
    context.read<ChannelsManager>().setSelectedChannel(channel);
    Navigator.of(context).pushNamed(ChannelScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final hasNewThreads =
        context.watch<ChannelsManager>().hasNewThreads(channel.id!);
    return ListTile(
      onTap: () => _navigateToChannel(context, channel),
      leading: Icon(getChannelIcon(channel.privacy)),
      title: Text(
        channel.name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: hasNewThreads ? FontWeight.bold : FontWeight.normal,
            ),
      ),
      trailing: hasNewThreads
          ? Icon(
              Icons.circle,
              color: statusColor[StatusType.success],
              size: 10,
            )
          : null,
    );
  }
}
