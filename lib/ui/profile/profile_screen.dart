import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../managers/index.dart';
import '../screens.dart';
import './widgets/index.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  const ProfileScreen(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    final loggedInUser = context.read<AuthManager>().loggedInUser!;
    bool isMyProfile = loggedInUser.id == user.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: isMyProfile ? [_buildInvitationButton(context)] : null,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfileHeader(user),
                const SizedBox(height: 20.0),
                ProfileDetails(user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInvitationButton(BuildContext context) {
    return IconButton(
      icon: Badge.count(
        count: context.watch<InvitationsManager>().count(),
        child: const Icon(Icons.mail),
      ),
      onPressed: () => _viewInvitation(context),
    );
  }

  void _viewInvitation(BuildContext context) {
    Navigator.of(context).pushNamed(InvitationScreen.routeName);
  }
}
