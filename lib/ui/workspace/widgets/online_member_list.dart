import 'package:flutter/material.dart';

import '../../../models/index.dart';
import './index.dart';

class OnlineMemberList extends StatelessWidget {
  const OnlineMemberList(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          ...workspace.members.map((member) {
            return OnlineMemberTile(member: member);
          }),
        ],
      ),
    );
  }
}
