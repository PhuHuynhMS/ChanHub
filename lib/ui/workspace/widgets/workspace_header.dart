import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/extensions/index.dart';
import '../../../managers/index.dart';
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
    Navigator.of(context)
        .pushNamed(AddWorkspaceMembersScreen.routeName, arguments: {
      'isCreating': false,
    });
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

  void _deleteWorkspace(BuildContext context) async {
    bool? isConfirmed = await showConfirmDialog(
      context: context,
      content: 'Are you sure you want to delete this workspace?',
    );
    if (isConfirmed && context.mounted) {
      context.executeWithErrorHandling(() async {
        final workspaceId =
            context.read<WorkspacesManager>().getSelectedWorkspaceId();

        await context.read<WorkspacesManager>().deleteWorkspace(workspaceId!);

        if (context.mounted) {
          if (context.read<WorkspacesManager>().getAll().isEmpty) {
            Navigator.of(context)
                .pushReplacementNamed(CreateWorkspaceScreen.routeName);
          } else {
            Navigator.of(context)
                .pushReplacementNamed(WorkspaceScreen.routeName);
          }
        }
      });
      // }
    }
  }

  List<Widget> _buildWorkspaceActions(BuildContext context) {
    const iconSize = 25.0;
    final userId = context.read<AuthManager>().loggedInUser?.id;
    bool isAdmin =
        context.read<WorkspacesManager>().isWorkspaceAdmin(userId!, workspace);

    if (isAdmin) {
      return [
        IconButton(
          iconSize: iconSize,
          onPressed: () => _navigateToManageMembers(context),
          icon: const Icon(Icons.manage_accounts),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        IconButton(
          iconSize: iconSize,
          color: Theme.of(context).colorScheme.onSurface,
          onPressed: () => _navigateToAddWorkspacesMembers(context),
          icon: const Icon(Icons.person_add),
        ),
        IconButton(
          iconSize: iconSize,
          color: Theme.of(context).colorScheme.error,
          onPressed: () => _deleteWorkspace(context),
          icon: const Icon(Icons.delete),
        ),
      ];
    } else {
      return [
        IconButton(
          iconSize: iconSize,
          onPressed: () => _navigateToManageMembers(context),
          icon: const Icon(Icons.people),
          color: Theme.of(context).colorScheme.onSurface,
        ),
        IconButton(
          iconSize: iconSize,
          onPressed: () => _leaveWorkspace(context),
          icon: const Icon(Icons.exit_to_app),
          color: Theme.of(context).colorScheme.error,
        ),
      ];
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
              Row(children: _buildWorkspaceActions(context))
            ],
          )
        ],
      ),
    );
  }
}
