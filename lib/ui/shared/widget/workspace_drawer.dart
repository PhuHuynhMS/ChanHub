import 'package:flutter/material.dart';

import '../../../models/workspace.dart';
import '../../workspace/workspace_screen.dart';
import '../../workspace/create_workspace_screen.dart';
import '../widget/workspace_tile.dart';

class WorkSpaceDrawer extends StatefulWidget {
  const WorkSpaceDrawer(
    this.workspaces, {
    super.key,
    this.selectedWorkspace,
  });

  final List<Workspace> workspaces;
  final Workspace? selectedWorkspace;

  @override
  State<WorkSpaceDrawer> createState() => _WorkSpaceDrawerState();
}

class _WorkSpaceDrawerState extends State<WorkSpaceDrawer> {
  void changeWorkspace(Workspace workspace) {
    if (isSelectedWorkspace(workspace)) {
      return;
    }

    setState(() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WorkspaceScreen(),
          settings: RouteSettings(
            arguments: workspace,
          ),
        ),
      );
    });
  }

  bool isSelectedWorkspace(Workspace workspace) {
    return widget.selectedWorkspace != null &&
        widget.selectedWorkspace!.id == workspace.id;
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
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
                fontWeight: FontWeight.bold,
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
            child: ListView(
              children: widget.workspaces
                  .map(
                    (workspace) => WorkspaceTile(
                      workspace,
                      onTap: () => changeWorkspace(workspace),
                      isSelectedWorkspace: isSelectedWorkspace(workspace),
                    ),
                  )
                  .toList(),
            ),
          ),
          Divider(
            height: 0.0,
            thickness: 1.0,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          ),

          // Workspace Actions
          Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, CreateWorkspaceScreen.routeName);
                },
                leading: const Icon(Icons.add),
                title: const Text('Add workspace'),
              ),
              ListTile(
                onTap: () {
                  print('Help');
                },
                leading: const Icon(Icons.help),
                title: const Text('Help'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
