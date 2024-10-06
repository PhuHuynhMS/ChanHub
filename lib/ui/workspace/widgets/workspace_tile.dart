import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';

class WorkspaceTile extends StatelessWidget {
  const WorkspaceTile(
    this.workspace, {
    super.key,
    required this.onTap,
    this.isSelectedWorkspace = false,
  });

  final Workspace workspace;
  final void Function() onTap;
  final bool isSelectedWorkspace;

  void showWorkspaceActions(BuildContext context) {
    showModalBottomSheetActions(
      context: context,
      header: WorkspaceActionsHeader(workspace),
      body: WorkspaceActions(workspace),
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
                : null,
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
                      workspace.imageUrl,
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10.0),

                  // Workspace Name
                  Text(
                    workspace.name,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: isSelectedWorkspace
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                        ),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),

              // More Options
              IconButton(
                onPressed: () => showWorkspaceActions(context),
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
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Workspace Image
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              width: 50,
              height: 50,
              workspace.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Workspace Name
        Text(
          workspace.name,
          style: Theme.of(context).textTheme.titleMedium,
        )
      ],
    );
  }
}

class WorkspaceActions extends StatelessWidget {
  const WorkspaceActions(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          onTap: () {},
          minTileHeight: 50.0,
          leading: const Icon(Icons.person_add_alt),
          title: Text(
            'Invite',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ListTile(
          onTap: () {},
          minTileHeight: 50.0,
          leading: Icon(
            Icons.exit_to_app,
            color: Theme.of(context).colorScheme.error,
          ),
          title: Text(
            'Leave',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
          ),
        ),
      ],
    );
  }
}
