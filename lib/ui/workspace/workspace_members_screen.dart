import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../shared/utils/index.dart';
import '../screens.dart';
import './widgets/index.dart';

class WorkspaceMembersScreen extends StatefulWidget {
  static const String routeName = '/workspaces/members';

  const WorkspaceMembersScreen({super.key});

  @override
  State<WorkspaceMembersScreen> createState() => _WorkspaceMembersScreenState();
}

class _WorkspaceMembersScreenState extends State<WorkspaceMembersScreen> {
  // TODO: List of workspace members
  List<User> allMembers = [
    User(
      id: '1',
      fullName: 'John Smith',
      jobTitle: "Flutter Developer",
      userName: 'john_smith',
      email: 'johnsmith@gmail.com',
      avatarUrl: 'https://picsum.photos/400/300',
    ),
    User(
      id: '2',
      fullName: 'Emily Brown',
      jobTitle: "Flutter Developer",
      userName: 'emily_brown',
      email: 'emily@gmail.com',
      avatarUrl: 'https://picsum.photos/350/300',
    ),
    User(
      id: '3',
      fullName: 'Michael Johnson',
      jobTitle: "Flutter Developer",
      userName: 'michael_j',
      email: 'michael@gmail.com',
      avatarUrl: 'https://picsum.photos/420/320',
    ),
    User(
      id: '4',
      fullName: 'Sophia White',
      jobTitle: "Flutter Developer",
      userName: 'sophia_w',
      email: 'sophia@gmail.com',
      avatarUrl: 'https://picsum.photos/400/400',
    ),
    User(
      id: '5',
      fullName: 'David Wilson',
      jobTitle: "Flutter Developer",
      userName: 'david_w',
      email: 'david@gmail.com',
      avatarUrl: 'https://picsum.photos/450/300',
    ),
    User(
      id: '6',
      fullName: 'Olivia Lee',
      jobTitle: "Flutter Developer",
      userName: 'olivia_lee',
      email: 'olivia@gmail.com',
      avatarUrl: 'https://picsum.photos/380/330',
    ),
    User(
      id: '7',
      fullName: 'Chris Martin',
      jobTitle: "Flutter Developer",
      userName: 'chris_m',
      email: 'chris@gmail.com',
      avatarUrl: 'https://picsum.photos/400/350',
    ),
    User(
      id: '8',
      fullName: 'Isabella Harris',
      jobTitle: "Flutter Developer",
      userName: 'isabella_h',
      email: 'isabella@gmail.com',
      avatarUrl: 'https://picsum.photos/370/340',
    ),
    User(
      id: '9',
      fullName: 'James Clark',
      jobTitle: "Flutter Developer",
      userName: 'james_c',
      email: 'james@gmail.com',
      avatarUrl: 'https://picsum.photos/430/300',
    ),
    User(
      id: '10',
      fullName: 'Mia Anderson',
      jobTitle: "Flutter Developer",
      userName: 'mia_a',
      email: 'mia@gmail.com',
      avatarUrl: 'https://picsum.photos/400/310',
    ),
    User(
      id: '11',
      fullName: 'Ethan Walker',
      jobTitle: "Flutter Developer",
      userName: 'ethan_w',
      email: 'ethan@gmail.com',
      avatarUrl: 'https://picsum.photos/420/380',
    ),
    User(
      id: '12',
      fullName: 'Ava Taylor',
      jobTitle: "Flutter Developer",
      userName: 'ava_t',
      email: 'ava@gmail.com',
      avatarUrl: 'https://picsum.photos/360/390',
    ),
    User(
      id: '13',
      fullName: 'Liam Thompson',
      jobTitle: "Flutter Developer",
      userName: 'liam_t',
      email: 'liam@gmail.com',
      avatarUrl: 'https://picsum.photos/410/310',
    ),
    User(
      id: '14',
      fullName: 'Charlotte Miller',
      jobTitle: "Flutter Developer",
      userName: 'charlotte_m',
      email: 'charlotte@gmail.com',
      avatarUrl: 'https://picsum.photos/380/360',
    ),
    User(
      id: '15',
      fullName: 'Lucas Moore',
      jobTitle: "Flutter Developer",
      userName: 'lucas_m',
      email: 'lucas@gmail.com',
      avatarUrl: 'https://picsum.photos/400/320',
    ),
  ];
  late List<User> filteredMembers = allMembers;

  void _filterMembers(String query) {
    if (query.isEmpty) {
      filteredMembers = allMembers;
      setState(() {});
      return;
    }
    filteredMembers = allMembers.where((member) {
      return member.fullName.toLowerCase().contains(query.toLowerCase());
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
                    onChanged: (value) => _filterMembers(value),
                  ),
                ),

                // Add members
                IconButton(
                  icon: const Icon(Icons.person_add),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AddWorkspaceMembersScreen.routeName);
                  },
                ),
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
      )),
    );
  }
}
