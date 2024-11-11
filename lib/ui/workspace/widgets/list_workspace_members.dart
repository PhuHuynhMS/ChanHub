import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../screens.dart';

class ListWorkspaceMembers extends StatelessWidget {
  const ListWorkspaceMembers({
    super.key,
    required this.filteredMembers,
    required this.onRemoveMember,
  });

  final List<User> filteredMembers;
  final void Function(BuildContext context, User member) onRemoveMember;

  void _onViewProfile(BuildContext context, User member) {
    Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: member);
  }

  void _onRemoveMember(BuildContext context, User member) async {
    bool isConfirmed = await showConfirmDialog(
      context: context,
      content: 'Are you sure you want to remove this member?',
    );

    if (isConfirmed && context.mounted) {
      onRemoveMember(context, member);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthManager>().loggedInUser?.id;
    final selectedWorkspace =
        context.watch<WorkspacesManager>().getSelectedWorkspace();
    bool isAdmin = context
        .read<WorkspacesManager>()
        .isWorkspaceAdmin(userId!, selectedWorkspace!);

    return ListView.builder(
      itemCount: filteredMembers.length,
      itemBuilder: (context, index) {
        final member = filteredMembers[index];
        final isAdminTile = member.id == userId;

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(member.avatarUrl),
          ),
          title: Text(member.fullname),
          subtitle: Text(
            member.email,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          trailing: isAdmin && !isAdminTile
              ? IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () => _onRemoveMember(context, member),
                )
              : null,
          onTap: () => _onViewProfile(context, member),
        );
      },
    );
  }
}
