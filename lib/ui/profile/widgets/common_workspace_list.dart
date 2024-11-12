import 'package:flutter/material.dart';

import '../../../models/index.dart';
import './index.dart';

class CommonWorkspaceList extends StatelessWidget {
  const CommonWorkspaceList(this.workspaces, {super.key});

  final List<Workspace> workspaces;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Collaborative Spaces',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20.0),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            shrinkWrap: true,
            itemCount: workspaces.length,
            itemBuilder: (context, index) =>
                CommonWorkspaceTile(workspaces[index]),
          ),
        ],
      ),
    );
  }
}
