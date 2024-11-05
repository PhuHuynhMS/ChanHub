import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import './workspace_screen.dart';

import '../../models/index.dart';
import '../shared/widgets/index.dart';
import '../screens.dart';

class AddWorkspaceMembersScreen extends StatefulWidget {
  static const String routeName = '/workspace/members/add';

  const AddWorkspaceMembersScreen(
      {super.key, required this.workspaceName, required this.image});

  final String workspaceName;
  final File image;

  @override
  State<AddWorkspaceMembersScreen> createState() =>
      _AddWorkspaceMembersScreenState();
}

class _AddWorkspaceMembersScreenState extends State<AddWorkspaceMembersScreen> {
  List<User> selectedUsers = [];
  void _navigateToWorkspaceScreen(
      {bool isSkip = false, required BuildContext context}) async {
    if (isSkip) {
      selectedUsers.clear();
    }

    final workspaceId = await context
        .read<WorkspacesManager>()
        .addWorkspace(widget.workspaceName, widget.image);

    if (workspaceId != null && selectedUsers.isNotEmpty) {
      if (context.mounted) {
        await context
            .read<WorkspacesManager>()
            .addWorkspaceMembers(selectedUsers, workspaceId);
      }
    }
    Navigator.of(context).pushReplacementNamed(WorkspaceScreen.routeName);
  }

  void updateSelectedMembers(List<User> newMembers) {
    setState(() {
      selectedUsers = newMembers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Collaborators'),
        actions: [
          TextButton(
            onPressed: () =>
                _navigateToWorkspaceScreen(isSkip: true, context: context),
            child: Text(
              'Skip',
              style: Theme.of(context).primaryTextTheme.titleSmall,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invite Collaborators',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Search for and add collaborators to your workspace',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20.0),
                InviteMembersBar(
                    selectedUsers: selectedUsers,
                    onSelectedMembersChanged: updateSelectedMembers),
                // Invite button
                const SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedUsers.isNotEmpty
                        ? () => _navigateToWorkspaceScreen(context: context)
                        : null,
                    child: const Text('Create And Invite'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
