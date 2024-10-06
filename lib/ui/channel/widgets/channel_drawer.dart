import 'package:flutter/material.dart';

class ChannelDrawer extends StatelessWidget {
  const ChannelDrawer({super.key});

  void onEditChannelDescription() {
    print('Edit channel');
  }

  void onAddChannelMember() {
    print('Add channel member');
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
                  onTap: () {
                    // TODO: Implement search thread
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit channel'),
                  onTap: onEditChannelDescription,
                ),
                ListTile(
                  leading: const Icon(Icons.people),
                  title: const Text('View members'),
                  onTap: () {
                    // TODO: Implement view members
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_add),
                  title: const Text('Add member'),
                  onTap: onAddChannelMember,
                ),
              ],
            ),
          ),
          const Divider(),

          // Workspace Actions
          ListTile(
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
