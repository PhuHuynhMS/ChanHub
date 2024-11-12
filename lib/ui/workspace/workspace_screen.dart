import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../managers/index.dart';
import '../shared/utils/loading_animation.dart';
import '../shared/extensions/index.dart';
import './widgets/index.dart';

class WorkspaceScreen extends StatelessWidget {
  static const String routeName = '/workspace';

  const WorkspaceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final workspaces = context.read<WorkspacesManager>().getAll();
    final selectedWorkspace =
        context.read<WorkspacesManager>().getSelectedWorkspace();
    final isFetching = context.watch<WorkspacesManager>().isFetching;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChanHub'),
        actions: const <Widget>[
          ProfileButton(),
          SizedBox(width: 10.0),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () {
            return context.executeWithErrorHandling(() async {
              if (selectedWorkspace != null) {
                return context
                    .read<WorkspacesManager>()
                    .fetchSelectedWorkspace();
              }
              return context.read<WorkspacesManager>().fetchWorkspaces();
            });
          },
          child: _buildWorkspaceBody(
              context, workspaces, selectedWorkspace, isFetching)),
      drawer: const WorkSpaceDrawer(),
    );
  }

  Widget _buildWorkspaceBody(
    BuildContext context,
    List<Workspace> workspaces,
    Workspace? selectedWorkspace,
    bool isFetching,
  ) {
    if (isFetching) {
      return getLoadingAnimation(context);
    } else if (workspaces.isNotEmpty && selectedWorkspace != null) {
      return WorkspaceDescription(selectedWorkspace);
    } else {
      return const WorkspaceGetStarted();
    }
  }
}
