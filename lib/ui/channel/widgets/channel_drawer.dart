import 'package:flutter/material.dart';

import '../../shared/utils/index.dart';
import '../../../ui/screens.dart';

class ChannelDrawer extends StatelessWidget {
  const ChannelDrawer({super.key});

  void _onSearchThread(BuildContext context) {
    print('Search thread');
  }

  void _onEditChannelDescription(BuildContext context) {
    Navigator.of(context).pushNamed(EditChannelScreen.routeName);
  }

  void _onViewMembers(BuildContext context) {
    print('View members');
  }

  void _onAddChannelMember(BuildContext context) {
    print('Add channel member');
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
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit channel'),
                  onTap: () => _onEditChannelDescription(context),
                ),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('View members'),
                  onTap: () => _onViewMembers(context),
                ),
                ListTile(
                  leading: const Icon(Icons.person_add),
                  title: const Text('Add member'),
                  onTap: () => _onAddChannelMember(context),
                ),
              ],
            ),
          ),
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
      ),
    );
  }
}
