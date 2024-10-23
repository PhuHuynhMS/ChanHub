import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../screens.dart';
import './add_channel_memer_tile.dart';

class AddChannelMembers extends StatefulWidget {
  const AddChannelMembers({
    super.key,
    required this.filteredMembers,
    required this.onAddMember,
  });

  final List<User> filteredMembers;
  final void Function(User member) onAddMember;

  @override
  State<AddChannelMembers> createState() => _AddChannelMembersState();
}

class _AddChannelMembersState extends State<AddChannelMembers> {
  bool isAdded = false;
  void _onViewProfile(BuildContext context, User member) {
    Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: member);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.filteredMembers.length,
      itemBuilder: (context, index) {
        final member = widget.filteredMembers[index];

        return AddChannelMemberTile(
          member: member,
          onViewProfile: _onViewProfile,
          onAddMember: widget.onAddMember,
        );
      },
    );
  }
}
