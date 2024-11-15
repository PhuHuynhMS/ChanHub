import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';

class CommonWorkspaceTile extends StatelessWidget {
  const CommonWorkspaceTile(this.workspace, {super.key});

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToWorkspace(context),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              workspace.imageUrl!,
              fit: BoxFit.cover,
              width: 45,
              height: 45,
            ),
          ),
          Text(
            truncate(workspace.name, 6),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }

  void _navigateToWorkspace(BuildContext context) {
    context.read<WorkspacesManager>().setSelectedWorkspace(workspace.id);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
