import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../../models/index.dart';
import '../shared/extensions/index.dart';
import '../shared/utils/index.dart';
import './widgets/index.dart';

class AddChannelMembersScreen extends StatefulWidget {
  static const String routeName = '/channel/add_members';

  const AddChannelMembersScreen({super.key});

  @override
  State<AddChannelMembersScreen> createState() => _AddChannelMembersState();
}

class _AddChannelMembersState extends State<AddChannelMembersScreen> {
  late List<User> filteredMembers;
  late List<User> allMembers;

  @override
  void initState() {
    super.initState();
    final allChannelMembers =
        context.read<ChannelsManager>().getAllChannelMembers();
    List<User> allWorkspaceMembers =
        context.read<WorkspacesManager>().getAllMembers();

    for (final channelMember in allChannelMembers) {
      allWorkspaceMembers.removeWhere(
          (workspaceMember) => workspaceMember.id == channelMember.id);
    }
    allMembers = allWorkspaceMembers;
    filteredMembers = allMembers;
  }

  void _filterMembers(String query) {
    if (query.isEmpty) {
      filteredMembers = allMembers;
      setState(() {});
      return;
    }
    filteredMembers = allMembers.where((member) {
      return member.fullname.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {});
  }

  void _onAddMember(User member) {
    context.executeWithErrorHandling(() async {
      final user = context.read<AuthManager>().loggedInUser;
      final actionMessage = "'${user!.fullname}' added '${member.fullname}'";
      await context.read<ChannelsManager>().addChannelMember(member);
      if (mounted) {
        await context
            .read<ChannelsManager>()
            .getCurrentThreadsManager()
            .createThreadEvent(actionMessage);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Channel Members'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                // Search bar
                Expanded(
                  child: TextField(
                    decoration: underlineInputDecoration(
                      context,
                      'Search members',
                      prefixIcon: const Icon(Icons.search),
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                    onChanged: (value) => _filterMembers(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Members
            Expanded(
              child: AddChannelMembers(
                filteredMembers: filteredMembers,
                onAddMember: _onAddMember,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
