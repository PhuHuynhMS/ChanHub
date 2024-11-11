import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/enums.dart';
import '../../../managers/index.dart';
import '../../shared/utils/index.dart';
import '../../screens.dart';

class ChannelDrawer extends StatelessWidget {
  const ChannelDrawer({super.key});

  void _onSearchThread(BuildContext context) {
    Navigator.of(context).pushNamed(SearchThreadScreen.routeName);
  }

  void _onEditChannel(BuildContext context) {
    final selectedChannel =
        context.read<ChannelsManager>().getSelectedChannel();
    Navigator.of(context).pushNamed(
      EditChannelScreen.routeName,
      arguments: selectedChannel,
    );
  }

  void _onViewMembers(BuildContext context) {
    Navigator.of(context).pushNamed(ViewChannelMembersScreen.routeName);
  }

  void _onAddChannelMember(BuildContext context) {
    Navigator.of(context).pushNamed(AddChannelMembersScreen.routeName);
  }

  void _onLeaveChannel(BuildContext context) async {
    bool isConfirmed = await showConfirmDialog(
      context: context,
      title: 'Leave channel',
      content: 'Are you sure you want to leave this channel?',
    );

    if (isConfirmed && context.mounted) {
      // TODO: Implement leave channel
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUser = context.read<AuthManager>().loggedInUser;
    final selectedChannel =
        context.read<ChannelsManager>().getSelectedChannel();

    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workspaces Header
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 15.0),
            child: Text(
              'Channel Actions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Divider(height: 20.0),

          // Workspaces List
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.search),
                  title: const Text('Search thread'),
                  onTap: () => _onSearchThread(context),
                ),
                if (loggedInUser!.id == selectedChannel!.creator!.id &&
                    selectedChannel.privacy == ChannelPrivacy.private) ...[
                  ListTile(
                    leading: const Icon(Icons.edit),
                    title: const Text('Edit channel'),
                    onTap: () => _onEditChannel(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Add member'),
                    onTap: () => _onAddChannelMember(context),
                  ),
                ],
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('View members'),
                  onTap: () => _onViewMembers(context),
                ),
              ],
            ),
          ),

          if (loggedInUser.id != selectedChannel.creator!.id &&
              selectedChannel.privacy == ChannelPrivacy.private) ...[
            const Divider(),

            // Workspace Actions
            ListTile(
              onTap: () => _onLeaveChannel(context),
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Leave channel'),
              textColor: Theme.of(context).colorScheme.error,
              iconColor: Theme.of(context).colorScheme.error,
            ),
          ],
        ],
      ),
    );
  }
}
