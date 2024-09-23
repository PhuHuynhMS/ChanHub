import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../../common/enums.dart';
import '../shared/utils/string_format.dart';
import '../channel/channel_screen.dart';

class WorkspaceDescription extends StatelessWidget {
  const WorkspaceDescription(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WorkspaceHeader(workspace),
        Divider(
          thickness: 1.0,
          height: 0.0,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
        WorkSpaceContent(workspace),
      ],
    );
  }
}

class WorkspaceHeader extends StatelessWidget {
  const WorkspaceHeader(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Workspace Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              workspace.imageUrl,
              fit: BoxFit.cover,
              width: 120,
              height: 120,
            ),
          ),

          // Workspace
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Workspace Name
              Text(
                truncate(workspace.name.toUpperCase(), 20),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 10.0,
              ),

              // Workspace Actions
              Row(
                children: [
                  IconButton(
                    iconSize: 25.0,
                    onPressed: () {},
                    icon: const Icon(Icons.manage_accounts),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconButton(
                    iconSize: 25.0,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_alt),
                  ),
                  IconButton(
                    iconSize: 25.0,
                    onPressed: () {},
                    icon: const Icon(Icons.exit_to_app),
                    color: Theme.of(context).colorScheme.error,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class WorkSpaceContent extends StatelessWidget {
  const WorkSpaceContent(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      collapsedIconColor: Theme.of(context).colorScheme.primary,
      shape: const Border(),
      title: Text(
        'Channels',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      children: [
        // Channels
        ...(workspace.channels.map((channel) => ChannelTile(channel)).toList()),

        // Add Channel
        ListTile(
          onTap: () => {},
          leading: const Icon(Icons.add),
          title: Text(
            'Add channel',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        )
      ],
    );
  }
}

class ChannelTile extends StatelessWidget {
  const ChannelTile(
    this.channel, {
    super.key,
  });

  final Channel channel;

  void navigateToChannel(BuildContext context, Channel channel) {
    Navigator.of(context).pushNamed(
      ChannelScreen.routeName,
      arguments: channel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => navigateToChannel(context, channel),
      leading: channel.privacy == ChannelPrivacy.public
          ? const Icon(Icons.public)
          : const Icon(Icons.lock_outlined),
      title: Text(
        channel.name,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}