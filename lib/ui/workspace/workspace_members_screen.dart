import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../managers/index.dart';
import '../shared/extensions/index.dart';
import '../shared/utils/index.dart';
import './widgets/index.dart';

class WorkspaceMembersScreen extends StatefulWidget {
  static const String routeName = '/workspaces/members';

  const WorkspaceMembersScreen({super.key});

  @override
  State<WorkspaceMembersScreen> createState() => _WorkspaceMembersScreenState();
}

class _WorkspaceMembersScreenState extends State<WorkspaceMembersScreen> {
  List<User> allMembers = [];
  late List<User> filteredMembers = [];
  bool isAdmin = false;

  void _filterMembers(String query, List<User> allMembers) {
    if (query.isEmpty) {
      filteredMembers = allMembers;
    }
    filteredMembers = allMembers.where((member) {
      return member.fullname.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void _onRemoveMember(BuildContext context, User member) async {
    context.executeWithErrorHandling(() async {
      bool isDeleted =
          await context.read<WorkspacesManager>().deleteWorkspaceMember(member);

      if (context.mounted && isDeleted) {
        await context.read<WorkspacesManager>().fetchSelectedWorkspace();
      }

      filteredMembers.remove(member);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final allMembers = context.watch<WorkspacesManager>().getAllMembers();
    final filteredMembers = [...allMembers];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workspace Members'),
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
                      onChanged: (value) => _filterMembers(value, allMembers),
                    ),
                  ),

                  // Add members
                ],
              ),
              const SizedBox(height: 10.0),

              // Members
              Expanded(
                child: ListWorkspaceMembers(
                  filteredMembers: filteredMembers,
                  onRemoveMember: _onRemoveMember,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
