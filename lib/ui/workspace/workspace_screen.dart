import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../models/workspace.dart';
import '../../common/constants.dart';
import '../../common/enums.dart';
import '../shared/widget/workspace_drawer.dart';
import 'welcome_screen.dart';
import '../shared/utils/string_format.dart';
import '../channel/channel_screen.dart';
import '../../models/channel.dart';

class WorkspaceScreen extends StatelessWidget {
  static const String routeName = '/workspace';

  const WorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'john@gmail.com',
      avatarUrl: 'https://picsum.photos/300/300',
    );
    final List<Workspace> workspaces = [];
    final Workspace? selectedWorkspace = null;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('ChanHub'),
          actions: [
            GestureDetector(
              onTap: () {
                print('Go to profile page');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage:
                      NetworkImage(user?.avatarUrl ?? defaultUserAvatarUrl),
                ),
              ),
            ),
          ],
        ),
        body: buildWorkspaceBody(selectedWorkspace, context, workspaces),
        drawer: WorkSpaceDrawer(
          workspaces,
          selectedWorkspace: selectedWorkspace,
        ),
      ),
    );
  }

  Widget buildWorkspaceBody(
      Workspace? workspace, BuildContext context, List<Workspace> workspaces) {
    if (workspaces.isNotEmpty) {
      return Column(
        children: [
          WorkspaceHeader(workspace!),
          Divider(
            thickness: 1.0,
            height: 0.0,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),
          WorkSpaceContent(workspace),
        ],
      );
    } else {
      return WelcomeScreen();
    }
  }
}

class WorkspaceHeader extends StatelessWidget {
  const WorkspaceHeader(this.workspace, {super.key});
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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),

              // Workspace Actions
              Row(
                children: [
                  IconButton(
                    iconSize: 30.0,
                    onPressed: () {},
                    icon: const Icon(Icons.manage_accounts),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconButton(
                    iconSize: 30.0,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_alt),
                  ),
                  IconButton(
                    iconSize: 30.0,
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
  const WorkSpaceContent(this.workspace, {super.key});

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      shape: const Border(),
      title: Text('Channels',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          )),
      children: [
        // Channels
        ...(workspace.channels.map((channel) => ChannelTile(channel)).toList()),

        // Add Channel
        ListTile(
          onTap: () => {},
          leading: const Icon(Icons.add),
          title: Text(
            'Add channel',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        )
      ],
    );
  }
}

class ChannelTile extends StatelessWidget {
  const ChannelTile(this.channel, {super.key});

  final Channel channel;

  void navigateToChannel(BuildContext context, Channel channel) {
    Navigator.pushNamed(
      context,
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
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
        ),
      ),
    );
  }
}
