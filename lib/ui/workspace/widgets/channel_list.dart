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
    return FutureBuilder(
        future: context.read<ChannelsManager>().fetchChannels(workspace.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return getLoadingAnimation(context);
          }
          return Column(
            children: <Widget>[
              ...context.read<ChannelsManager>().getAll().map((channel) {
                return ChannelTile(
                  channel,
                );
              }),
            ],
          );
        });
  }
}
