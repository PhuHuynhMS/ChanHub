import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/index.dart';
import '../../../managers/index.dart';
import '../../screens.dart';
import '../../shared/utils/index.dart';
import '../../shared/extensions/index.dart';

class WorkspaceTile extends StatelessWidget {
  const WorkspaceTile(
    this.workspace, {
    super.key,
    required this.onTap,
    this.isSelectedWorkspace = false,
    this.isDefaultWorkspace = false,
    this.isAdmin = false,
  });

  final Workspace workspace;
  final void Function() onTap;
  final bool isSelectedWorkspace;
  final bool isDefaultWorkspace;
  final bool isAdmin;

  void _showWorkspaceActions(BuildContext context) {
    showModalBottomSheetActions(
      context: context,
      header: WorkspaceActionsHeader(
        workspace,
        isDefaultWorkspace: isDefaultWorkspace,
      ),
      body: WorkspaceActions(
        workspace,
        isDefaultWorkspace: isDefaultWorkspace,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: isSelectedWorkspace
                ? Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3.0,
                  )
                : Border.all(
                    color: Colors.transparent,
                    width: 3.0,
                  ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Workspace Image and Name
              Row(
                children: [
                  // Workspace Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      workspace.imageUrl!,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10.0),

                  // Workspace Name
                  Text(
                    truncate(workspace.name, 20),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: isSelectedWorkspace
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                  )
                ],
              ),

              // More Options
              IconButton(
                onPressed: () => _showWorkspaceActions(context),
                icon: const Icon(Icons.more_vert),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WorkspaceActionsHeader extends StatelessWidget {
  const WorkspaceActionsHeader(
    this.workspace, {
    super.key,
    this.isDefaultWorkspace = false,
  });

  final Workspace workspace;
  final bool isDefaultWorkspace;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: [
          // Workspace Image
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              width: 50,
              height: 50,
              workspace.imageUrl!,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10.0),
          // Workspace Name
          Text(
            workspace.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),

          if (isDefaultWorkspace) ...[
            const Spacer(),
            const Icon(Icons.star),
          ]
        ],
      ),
    );
  }
}

class WorkspaceActions extends StatelessWidget {
  const WorkspaceActions(
    this.workspace, {
    super.key,
    this.isDefaultWorkspace = false,
  });

  final Workspace workspace;
  final bool isDefaultWorkspace;

  void _setDefaultWorkspace(BuildContext context) async {
    context.executeWithErrorHandling(() async {
      await context.read<WorkspacesManager>().setDefaultWorkspace(workspace);
      if (context.mounted) {
        Navigator.of(context).pop();
        context.read<WorkspacesManager>().setSelectedWorkspace(workspace.id);
      }
    });
  }

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
      context.executeWithErrorHandling(() async {
        final member = context.read<AuthManager>().loggedInUser;
        await context
            .read<WorkspacesManager>()
            .deleteWorkspaceMember(member!, workspace);
        if (context.mounted) {
          await context.read<WorkspacesManager>().fetchWorkspaces();
        }
        if (context.mounted) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
    }
  }

  void _navigateToEditWorkspace(BuildContext context, Workspace workspace) {
    Navigator.of(context).pushNamed(EditWorkspaceScreen.routeName, arguments: {
      'workspace': workspace,
    });
  }

  List<Widget> _buildWorkspaceActions(BuildContext context) {
    final userId = context.read<AuthManager>().loggedInUser?.id;
    bool isAdmin =
        context.read<WorkspacesManager>().isWorkspaceAdmin(userId!, workspace);

    if (isAdmin) {
      return [
        ListTile(
          onTap: () => _navigateToEditWorkspace(context, workspace),
          leading: Icon(
            Icons.edit,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'Edit workspace',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        ListTile(
          onTap: () => _navigateToManageMembers(context),
          leading: Icon(
            Icons.manage_accounts,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'Manage members',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        ListTile(
          onTap: () => _navigateToAddWorkspacesMembers(context),
          leading: Icon(
            Icons.person_add,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'Add members',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        ListTile(
          onTap: () => _deleteWorkspace(context),
          leading: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text(
            'Delete workspace',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ];
    } else {
      return [
        ListTile(
          onTap: () => _navigateToManageMembers(context),
          leading: Icon(
            Icons.people,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'View members',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        ListTile(
          onTap: () => _leaveWorkspace(context),
          leading: Icon(
            Icons.exit_to_app,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text(
            'Leave',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ];
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
          Navigator.of(context).pushReplacementNamed(WorkspaceScreen.routeName);
        }
      });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        if (!isDefaultWorkspace) ...[
          ListTile(
            onTap: () => _setDefaultWorkspace(context),
            leading: const Icon(Icons.check),
            title: Text(
              'Mark as default workspace',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
        ..._buildWorkspaceActions(context),
      ],
    );
  }
}
