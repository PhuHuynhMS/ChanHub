import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../screens.dart';
import './index.dart';

class WorkSpaceDrawer extends StatelessWidget {
  const WorkSpaceDrawer(
    this.workspaces, {
    super.key,
    this.selectedWorkspace,
  });

  final List<Workspace> workspaces;
  final Workspace? selectedWorkspace;

  void _changeWorkspace(BuildContext context, Workspace workspace) {
    Navigator.of(context).pushReplacementNamed(
      WorkspaceScreen.routeName,
      arguments: workspace,
    );
  }

  void _createWorkspace(BuildContext context) {
    Navigator.of(context).pushNamed(CreateWorkspaceScreen.routeName);
  }

  void _goToHelp(BuildContext context) {
    print('Help');
  }

  bool _isSelectedWorkspace(Workspace workspace) {
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
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Divider(height: 20.0),

          // Workspaces List
          Expanded(
            child: ListView.builder(
              itemCount: workspaces.length,
              itemBuilder: (context, index) => WorkspaceTile(
                workspaces[index],
                isSelectedWorkspace: _isSelectedWorkspace(workspaces[index]),
                onTap: () => _changeWorkspace(context, workspaces[index]),
              ),
            ),
          ),
          const Divider(),

          // Workspace Actions
          ListTile(
            onTap: () => _createWorkspace(context),
            leading: const Icon(Icons.add),
            title: const Text('Add workspace'),
            textColor: Theme.of(context).colorScheme.primary,
          ),
          ListTile(
            onTap: () => _goToHelp(context),
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            textColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
