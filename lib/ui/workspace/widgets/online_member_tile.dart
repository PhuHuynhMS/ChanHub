import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';

class OnlineMemberTile extends StatelessWidget {
  const OnlineMemberTile({
    super.key,
    required this.member,
  });

  final User member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 20.0,
            backgroundImage: NetworkImage(member.avatarUrl),
          ),
          Text(
            truncate(member.fullName, 7),
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
