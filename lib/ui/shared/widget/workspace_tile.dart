import 'package:flutter/material.dart';
import '../../../models/workspace.dart';
import '../utils/string_format.dart';

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
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return WorkspaceActions(workspace: workspace);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(
                color: isSelectedWorkspace
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.surface,
                width: 3.0,
              )),
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
                    truncate(workspace.name, 20),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize:
                          Theme.of(context).textTheme.titleSmall!.fontSize,
                    ),
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

class WorkspaceActions extends StatelessWidget {
  const WorkspaceActions({
    super.key,
    required this.workspace,
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Workspace Image
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  width: 60,
                  height: 60,
                  workspace.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),

            // Workspace Name
            Text(
              workspace.name,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: Theme.of(context).textTheme.titleLarge!.fontSize),
            )
          ],
        ),
        Divider(
          height: 0.0,
          thickness: 1.0,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),

        // Actions
        ListTile(
          onTap: () {},
          minTileHeight: 50.0,
          leading: const Icon(Icons.person_add_alt),
          title: Text(
            'Invite',
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            ),
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
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
