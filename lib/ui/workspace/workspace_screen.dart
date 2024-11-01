import 'package:ct484_project/ui/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../../models/index.dart';
import './widgets/index.dart';

class WorkspaceScreen extends StatefulWidget {
  static const String routeName = '/workspace';

  const WorkspaceScreen({
    super.key,
  });

  @override
  State<WorkspaceScreen> createState() => _WorkspaceScreenState();
}

class _WorkspaceScreenState extends State<WorkspaceScreen> {
  // TODO: User who is logged in
  final User user = User(
    id: '1',
    fullname: 'John Doe',
    jobTitle: 'Software Developer',
    username: 'johndoe',
    email: 'john@gmail.com',
    avatarUrl: 'https://picsum.photos/300/300',
  );

  late Future<void> _fetchChannels;

  @override
  void initState() {
    super.initState();

    final workspacesManager = context.read<WorkspacesManager>();
    final channelsManager = context.read<ChannelsManager>();

    final selectedWorkspace = workspacesManager.getSelectedWorkspace();
    if (selectedWorkspace != null) {
      _fetchChannels = channelsManager.fetchChannels(selectedWorkspace.id);
    } else {
      _fetchChannels = Future.value();
    }
  }

  @override
  Widget build(BuildContext context) {
    final workspaces = context.watch<WorkspacesManager>().getAll();
    final selectedWorkspace =
        context.watch<WorkspacesManager>().getSelectedWorkspace();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChanHub'),
        actions: <Widget>[
          ProfileButton(user: user),
          const SizedBox(width: 10.0),
        ],
      ),
      body: FutureBuilder(
          future: _fetchChannels,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return _buildWorkspaceBody(
                  selectedWorkspace, context, workspaces);
            }
            return const Center(child: SplashScreen());
          }),
      drawer: const WorkSpaceDrawer(),
    );
  }

  Widget _buildWorkspaceBody(
    Workspace? selectedWorkspace,
    BuildContext context,
    List<Workspace>? workspaces,
  ) {
    if (workspaces != null && selectedWorkspace != null) {
      return WorkspaceDescription(selectedWorkspace);
    } else {
      return const WorkspaceGetStarted();
    }
  }
}
