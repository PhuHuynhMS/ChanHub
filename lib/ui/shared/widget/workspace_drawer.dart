import 'package:flutter/material.dart';

import '../../../models/workspace.dart';
import '../../workspace/workspace_screen.dart';
import '../../workspace/create_workspace_screen.dart';
import '../widget/workspace_tile.dart';

class WorkSpaceDrawer extends StatelessWidget {
  const WorkSpaceDrawer(
    this.workspaces, {
    super.key,
    this.selectedWorkspace,
  });

  final List<Workspace> workspaces;
  final Workspace? selectedWorkspace;

  void changeWorkspace(BuildContext context, Workspace workspace) {
    Navigator.of(context).pushReplacementNamed(
      WorkspaceScreen.routeName,
      arguments: workspace,
    );
  }

  void createWorkspace(BuildContext context) {
    Navigator.of(context).pushNamed(CreateWorkspaceScreen.routeName);
  }

  void goToHelp(BuildContext context) {
    print('Help');
  }

  bool isSelectedWorkspace(Workspace workspace) {
    return selectedWorkspace != null && selectedWorkspace!.id == workspace.id;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workspaces Header
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15.0),
            child: Text(
              'Workspaces',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
          Divider(
            height: 20.0,
            thickness: 1.0,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),

          // Workspaces List
          Expanded(
            child: ListView.builder(
              itemCount: workspaces.length,
              itemBuilder: (context, index) => WorkspaceTile(
                workspaces[index],
                isSelectedWorkspace: isSelectedWorkspace(workspaces[index]),
                onTap: () => changeWorkspace(context, workspaces[index]),
              ),
            ),
          ),
          Divider(
            height: 0.0,
            thickness: 1.0,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),

          // Workspace Actions
          ListTile(
            onTap: () => createWorkspace(context),
            leading: const Icon(Icons.add),
            title: const Text('Add workspace'),
          ),
          ListTile(
            onTap: () => goToHelp(context),
            leading: const Icon(Icons.help),
            title: const Text('Help'),
          ),
        ],
      ),
    );
  }
}
