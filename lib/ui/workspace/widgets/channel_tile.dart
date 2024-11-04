import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return ListTile(
      onTap: () => _navigateToChannel(context, channel),
      leading: Icon(getChannelIcon(channel.privacy)),
      title: Text(channel.name),
    );
  }
}
