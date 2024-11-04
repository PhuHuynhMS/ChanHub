import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/index.dart';
import '../../../managers/index.dart';
import '../../shared/utils/loading_animation.dart';
import './index.dart';

class ChannelList extends StatelessWidget {
  const ChannelList(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<ChannelsManager>().isFetching;
    List<Channel> channels = context.read<ChannelsManager>().getAll();

    return isLoading
        ? getLoadingAnimation(context)
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: channels.length,
            itemBuilder: (BuildContext context, int index) {
              return ChannelTile(channels[index]);
            },
          );
  }
}
