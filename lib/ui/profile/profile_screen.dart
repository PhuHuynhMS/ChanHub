import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../managers/index.dart';
import '../shared/utils/index.dart';
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
    context.read<InvitationsManager>().fetchInvitations();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: isMyProfile
            ? [
                _buildInvitationButton(context),
                _buildSettingsButton(context),
                const SizedBox(width: 5.0),
              ]
            : null,
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

                // Show the workspaces with the user is a member of if it's not the user's profile
                if (!isMyProfile) ...[
                  const SizedBox(height: 20.0),
                  CommonWorkspaceList(_getCommonWorkspaces(context)),
                ],
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

  Widget _buildSettingsButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => showActionDialog(
        context: context,
        title: 'Settings',
        content: const SettingsForm(),
      ),
    );
  }

  void _viewInvitation(BuildContext context) {
    Navigator.of(context).pushNamed(InvitationScreen.routeName);
  }

  List<Workspace> _getCommonWorkspaces(BuildContext context) {
    final loggedInUserWorkspaces = context.read<WorkspacesManager>().getAll();
    return loggedInUserWorkspaces
        .where((workspace) =>
            workspace.members.any((member) => member.id == user.id))
        .take(8)
        .toList();
  }
}
