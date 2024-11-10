import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../shared/widgets/index.dart';
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
      child: SizedBox(
        width: 60.0,
        child: Column(
          children: <Widget>[
            UserAvatar(
              member,
              size: 40.0,
              borderRadius: 20.0,
            ),
            Text(
              truncate(member.fullname, 7),
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
