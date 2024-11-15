import 'dart:math';

import 'package:flutter/material.dart';

import '../../../models/index.dart';
import './index.dart';

class OnlineMemberGrid extends StatefulWidget {
  const OnlineMemberGrid(
    this.workspace, {
    super.key,
  });

  final Workspace workspace;

  @override
  State<OnlineMemberGrid> createState() => _OnlineMemberGridState();
}

class _OnlineMemberGridState extends State<OnlineMemberGrid> {
  int maximumMembersShow = 8;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        width: MediaQuery.of(context).size.width,
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: min(widget.workspace.members.length, maximumMembersShow),
          itemBuilder: (context, index) {
            if (index == maximumMembersShow - 1) {
              return _buildMoreMembersButton();
            }
            return OnlineMemberTile(member: widget.workspace.members[index]);
          },
        ),
      ),
    );
  }

  Widget _buildMoreMembersButton() {
    return GestureDetector(
      onTap: () {
        setState(() {
          maximumMembersShow += 8;
        });
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: <Widget>[
          const Icon(Icons.more_horiz, size: 40.0),
          Text(
            'more',
            style: Theme.of(context).textTheme.titleSmall,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
