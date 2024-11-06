import 'package:flutter/material.dart';

import '../../../models/index.dart';
import './index.dart';

class WorkspaceDescription extends StatelessWidget {
  const WorkspaceDescription(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          WorkspaceHeader(workspace),
          const Divider(),
          WorkSpaceContent(workspace),
        ],
      ),
    );
  }
}
