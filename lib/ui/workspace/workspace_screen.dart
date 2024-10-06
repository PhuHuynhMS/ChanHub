import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../screens.dart';
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
    userName: 'johndoe',
    email: 'john@gmail.com',
    avatarUrl: 'https://picsum.photos/300/300',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text('ChanHub'),
          actions: [
            ProfileButton(user: user),
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

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.user,
  });

  final User user;

  void goToProfilePage(BuildContext context) {
    Navigator.of(context).pushNamed(
      ProfileScreen.routeName,
      arguments: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToProfilePage(context),
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
      ),
    );
  }
}
