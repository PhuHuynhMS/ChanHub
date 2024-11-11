import 'package:ct484_project/managers/index.dart';
import 'package:ct484_project/ui/profile/change_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../screens.dart';

class ListChannelMembers extends StatelessWidget {
  const ListChannelMembers({
    super.key,
    required this.filteredMembers,
    required this.onRemoveMember,
  });

  final List<User> filteredMembers;
  final void Function(User member) onRemoveMember;

  void _onViewProfile(BuildContext context, User member) {
    Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: member);
  }

  void _onRemoveMember(BuildContext context, User member) async {
    bool isConfirmed = await showConfirmDialog(
      context: context,
      content: 'Are you sure you want to remove this member?',
    );

    if (isConfirmed) {
      onRemoveMember(member);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AuthManager>().loggedInUser?.id;
    return ListView.builder(
      itemCount: filteredMembers.length,
      itemBuilder: (context, index) {
        final member = filteredMembers[index];

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(member.avatarUrl),
          ),
          title: Text(member.fullname),
          subtitle: Text(
            member.email,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          trailing: userId == member.id
              ? null
              : IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () => _onRemoveMember(context, member),
                ),
          onTap: () => _onViewProfile(context, member),
        );
      },
    );
  }
}
