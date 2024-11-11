import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/utils/string_format.dart';

class CommonWorkspaceTile extends StatelessWidget {
  const CommonWorkspaceTile(this.workspace, {super.key});

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
    ]);
  }
}
