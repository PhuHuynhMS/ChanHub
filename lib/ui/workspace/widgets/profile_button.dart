import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../shared/widgets/index.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final loggedInUser = context.watch<AuthManager>().loggedInUser!;

    return UserAvatar(
      loggedInUser,
      size: 40.0,
      borderRadius: 20.0,
    );
  }
}
