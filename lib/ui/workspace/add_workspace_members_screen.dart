import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../../models/index.dart';
import '../shared/extensions/index.dart';
import '../screens.dart';
import './widgets/index.dart';

class AddWorkspaceMembersScreen extends StatefulWidget {
  static const String routeName = '/workspace/members/add';

  const AddWorkspaceMembersScreen({
    super.key,
    this.workspaceName,
    this.image,
    this.isCreating = false,
  });

  final String? workspaceName;
  final File? image;
  final bool isCreating;

  @override
  State<AddWorkspaceMembersScreen> createState() =>
      _AddWorkspaceMembersScreenState();
}

class _AddWorkspaceMembersScreenState extends State<AddWorkspaceMembersScreen> {
  List<User> selectedUsers = [];
  void _navigateToWorkspaceScreen({
    bool isSkip = false,
    required BuildContext context,
  }) async {
    if (widget.isCreating) {
      context.executeWithErrorHandling(() async {
        if (isSkip) {
          selectedUsers.clear();
        }

        await context
            .read<WorkspacesManager>()
            .addWorkspace(widget.workspaceName!, widget.image!, selectedUsers);

        if (context.mounted) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      });
    } else {}
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
