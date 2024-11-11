import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../../models/index.dart';
import '../shared/utils/index.dart';
import '../screens.dart';
import './widgets/index.dart';

class ViewChannelMembersScreen extends StatefulWidget {
  static const String routeName = '/channels/members';

  const ViewChannelMembersScreen({super.key});

  @override
  State<ViewChannelMembersScreen> createState() =>
      _ViewChannelMembersScreenState();
}

class _ViewChannelMembersScreenState extends State<ViewChannelMembersScreen> {
  late List<User> filteredMembers;
  late List<User> allMembers;

  @override
  void initState() {
    super.initState();
    allMembers = context.read<ChannelsManager>().getAllChannelMembers();
    filteredMembers = allMembers;
  }

  void _navigateToAddChannelMembersScreen() {
    Navigator.of(context).pushNamed(AddChannelMembersScreen.routeName);
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

  void _onRemoveMember(User member) {
    allMembers.remove(member);
    filteredMembers.remove(member);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Channel Members'),
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

                // Add members
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: _navigateToAddChannelMembersScreen,
                ),
              ],
            ),
            const SizedBox(height: 10.0),

            // Members
            Expanded(
              child: ListChannelMembers(
                filteredMembers: filteredMembers,
                onRemoveMember: _onRemoveMember,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
