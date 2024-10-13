import 'package:flutter/material.dart';

import '../../models/index.dart';
import './widgets/index.dart';

class WorkspaceScreen extends StatelessWidget {
  static const String routeName = '/workspace';

  WorkspaceScreen(
    this.workspaces, {
    super.key,
    this.selectedWorkspace,
  });

  final List<Workspace> workspaces;
  final Workspace? selectedWorkspace;

  // TODO: User who is logged in
  final User user = User(
    id: '1',
    fullName: 'John Doe',
    jobTitle: 'Software Developer',
    userName: 'johndoe',
    email: 'john@gmail.com',
    avatarUrl: 'https://picsum.photos/300/300',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChanHub'),
        actions: <Widget>[
          ProfileButton(user: user),
          const SizedBox(width: 10.0),
        ],
      ),
      body: _buildWorkspaceBody(selectedWorkspace, context, workspaces),
      drawer: WorkSpaceDrawer(
        workspaces,
        selectedWorkspace: selectedWorkspace,
      ),
    );
  }

  Widget _buildWorkspaceBody(
    Workspace? selectedWorkspace,
    BuildContext context,
    List<Workspace> workspaces,
  ) {
    if (workspaces.isNotEmpty && selectedWorkspace != null) {
      return WorkspaceDescription(selectedWorkspace);
    } else {
      return const WorkspaceGetStarted();
    }
  }
}
