import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../../models/index.dart';
import '../shared/utils/loading_animation.dart';
import './widgets/index.dart';

class WorkspaceScreen extends StatelessWidget {
  static const String routeName = '/workspace';

  const WorkspaceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final workspaces = context.watch<WorkspacesManager>().getAll();
    final selectedWorkspace =
        context.watch<WorkspacesManager>().getSelectedWorkspace();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChanHub'),
        actions: <Widget>[
          ProfileButton(),
          const SizedBox(width: 10.0),
        ],
      ),
      body: _buildWorkspaceBody(selectedWorkspace, context, workspaces),
      drawer: const WorkSpaceDrawer(),
    );
  }

  Widget _buildWorkspaceBody(
    Workspace? selectedWorkspace,
    BuildContext context,
    List<Workspace>? workspaces,
  ) {
    if (workspaces == null || selectedWorkspace == null) {
      return getLoadingAnimation(context);
    } else if (workspaces.isNotEmpty) {
      return WorkspaceDescription(selectedWorkspace);
    } else {
      return const WorkspaceGetStarted();
    }
  }
}
