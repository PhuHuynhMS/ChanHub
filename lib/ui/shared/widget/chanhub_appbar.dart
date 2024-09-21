import 'package:flutter/material.dart';

import '../../../models/user.dart';
import '../../../common/constants.dart';

class ChanHubAppBar extends StatelessWidget {
  const ChanHubAppBar({
    super.key,
    this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: const Text('ChanHub'),
      actions: [
        GestureDetector(
          onTap: () {
            print('Go to profile page');
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(user?.avatarUrl ?? defaultUserAvatarUrl),
            ),
          ),
        ),
      ],
    );
  }
}
