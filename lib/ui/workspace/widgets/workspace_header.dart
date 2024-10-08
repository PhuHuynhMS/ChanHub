import 'package:flutter/material.dart';

import '../../../models/index.dart';

class WorkspaceHeader extends StatelessWidget {
  const WorkspaceHeader(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

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
              workspace.imageUrl,
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
                    onPressed: () {
                      //TODO: Go to manage account page
                    },
                    icon: const Icon(Icons.manage_accounts),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconButton(
                    iconSize: 25.0,
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      //TODO: Add workspace friends
                    },
                    icon: const Icon(Icons.person_add_alt),
                  ),
                  IconButton(
                    iconSize: 25.0,
                    onPressed: () {
                      //TODO: Exit app
                    },
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
