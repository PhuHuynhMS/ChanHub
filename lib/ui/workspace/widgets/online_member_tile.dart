import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/widgets/index.dart';

class OnlineMemberTile extends StatelessWidget {
  const OnlineMemberTile({
    super.key,
    required this.member,
  });

  final User member;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserAvatar(
          member,
          size: 40.0,
          borderRadius: 20.0,
        ),
        Text(
          member.username,
          style: Theme.of(context).textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
