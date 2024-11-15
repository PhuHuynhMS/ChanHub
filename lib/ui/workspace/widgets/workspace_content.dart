import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../screens.dart';
import './index.dart';

class WorkSpaceContent extends StatelessWidget {
  const WorkSpaceContent(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  void _addChannel(BuildContext context) {
    Navigator.of(context).pushNamed(AddChannelScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Online Members
        ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          initiallyExpanded: true,
          title: Text(
            'Members',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: <Widget>[
            OnlineMemberGrid(workspace),
          ],
        ),

        const Divider(),
        // Channels
        ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            'Channels',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            // Channels
            ChannelList(workspace),

            // Add Channel
            ListTile(
              onTap: () => _addChannel(context),
              leading: const Icon(Icons.add),
              title: Text(
                'Add channel',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            )
          ],
        ),
      ],
    );
  }
}
