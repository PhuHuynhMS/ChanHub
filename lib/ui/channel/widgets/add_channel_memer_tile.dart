import 'package:flutter/material.dart';

import '../../../models/index.dart';

class AddChannelMemberTile extends StatefulWidget {
  const AddChannelMemberTile(
      {required this.member,
      required this.onViewProfile,
      required this.onAddMember,
      super.key});

  final User member;
  final void Function(BuildContext context, User member) onViewProfile;
  final void Function(User member) onAddMember;

  @override
  State<AddChannelMemberTile> createState() => _AddChannelMemberTileState();
}

class _AddChannelMemberTileState extends State<AddChannelMemberTile> {
  bool isAdded = false;

  void _onAddMember(User member) {
    widget.onAddMember(member);
    setState(() {
      isAdded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.member.avatarUrl),
      ),
      title: Text(widget.member.fullName),
      subtitle: Text(
        widget.member.email,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      trailing: IconButton(
          onPressed: () => _onAddMember(widget.member),
          icon: Icon(
            !isAdded ? Icons.add : Icons.check,
            color: Theme.of(context).colorScheme.primary,
          )),
      onTap: () => widget.onViewProfile(context, widget.member),
    );
  }
}
