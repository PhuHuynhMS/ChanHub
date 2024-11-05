import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/index.dart';
import '../../../managers/index.dart';
import '../../screens.dart';
import './index.dart';

class WorkSpaceDrawer extends StatelessWidget {
  const WorkSpaceDrawer({
    super.key,
  });

  void _changeWorkspace(BuildContext context, Workspace workspace) async {
    await context.read<WorkspacesManager>().setSelectedWorkspace(workspace.id);
    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  void _createWorkspace(BuildContext context) {
    Navigator.of(context).pushNamed(CreateWorkspaceScreen.routeName);
  }

  void _goToHelp(BuildContext context) {
    // TODO: For testing purposes
    context.read<AuthManager>().logout();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  bool _isSelectedWorkspace(Workspace workspace, Workspace? selectedWorkspace) {
    return selectedWorkspace != null && selectedWorkspace.id == workspace.id;
  }

  bool _isDefaultWorkspace(Workspace workspace, Workspace? isDefaultWorkspace) {
    return isDefaultWorkspace != null && isDefaultWorkspace.id == workspace.id;
  }

  @override
  Widget build(BuildContext context) {
    final workspaces = context.watch<WorkspacesManager>().getAll();
    final selectedWorkspace =
        context.watch<WorkspacesManager>().getSelectedWorkspace();
    final defaultWorkspace =
        context.watch<WorkspacesManager>().getDefaultWorkspace();
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
                isSelectedWorkspace: _isSelectedWorkspace(
                  workspaces[index],
                  selectedWorkspace,
                ),
                isDefaultWorkspace:
                    _isDefaultWorkspace(workspaces[index], defaultWorkspace),
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
