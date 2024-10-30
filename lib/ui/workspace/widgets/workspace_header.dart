import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../screens.dart';

class WorkspaceHeader extends StatelessWidget {
  const WorkspaceHeader(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  void _navigateToManageMembers(BuildContext context) {
    Navigator.of(context).pushNamed(WorkspaceMembersScreen.routeName);
  }

  void _navigateToAddWorkspacesMembers(BuildContext context) {
    Navigator.of(context).pushNamed(AddWorkspaceMembersScreen.routeName);
  }

  void _leaveWorkspace(BuildContext context) async {
    bool isConfirmed = await showConfirmDialog(
      context: context,
      content: 'Are you sure you want to leave this workspace?',
    );

    if (isConfirmed && context.mounted) {
      Navigator.of(context).pushNamed(WorkspaceScreen.routeName);
    }
  }

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
              workspace.imageUrl!,
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
                workspace.name.toUpperCase(),
                style: Theme.of(context).textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0),

              // Workspace Actions
              Row(
                children: [
                  IconButton(
                    iconSize: 25.0,
                    onPressed: () => _navigateToManageMembers(context),
                    icon: const Icon(Icons.manage_accounts),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconButton(
                    iconSize: 25.0,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () => _navigateToAddWorkspacesMembers(context),
                    icon: const Icon(Icons.person_add),
                  ),
                  IconButton(
                    iconSize: 25.0,
                    onPressed: () => _leaveWorkspace(context),
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
