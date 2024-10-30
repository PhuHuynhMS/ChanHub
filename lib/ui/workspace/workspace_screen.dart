import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../../models/index.dart';
import './widgets/index.dart';

class WorkspaceScreen extends StatelessWidget {
  static const String routeName = '/workspace';

  WorkspaceScreen({
    super.key,
  });

  // TODO: User who is logged in
  final User user = User(
    id: '1',
    fullname: 'John Doe',
    jobTitle: 'Software Developer',
    username: 'johndoe',
    email: 'john@gmail.com',
    avatarUrl: 'https://picsum.photos/300/300',
  );

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
      body: _buildWorkspaceBody(selectedWorkspace, context, workspaces),
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
