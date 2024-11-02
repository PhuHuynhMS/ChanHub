import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../screens.dart';

class ProfileButton extends StatelessWidget {
  ProfileButton({
    super.key,
  });

  final User user = User(
    id: '1',
    fullname: 'John Doe',
    jobTitle: 'Software Developer',
    username: 'johndoe',
    email: 'john@gmail.com',
    avatarUrl: 'https://picsum.photos/300/300',
  );

  void goToProfilePage(BuildContext context) {
    Navigator.of(context).pushNamed(
      ProfileScreen.routeName,
      arguments: user,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToProfilePage(context),
      child: CircleAvatar(
        backgroundImage: NetworkImage(user.avatarUrl),
      ),
    );
  }
}
