import 'package:flutter/material.dart';

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
  // TODO: List of workspace members
  List<User> allMembers = [
    User(
      id: '1',
      fullname: 'John Smith',
      jobTitle: "Flutter Developer",
      username: 'john_smith',
      email: 'johnsmith@gmail.com',
      avatarUrl: 'https://picsum.photos/400/300',
    ),
    User(
      id: '2',
      fullname: 'Emily Brown',
      jobTitle: "Flutter Developer",
      username: 'emily_brown',
      email: 'emily@gmail.com',
      avatarUrl: 'https://picsum.photos/350/300',
    ),
    User(
      id: '3',
      fullname: 'Michael Johnson',
      jobTitle: "Flutter Developer",
      username: 'michael_j',
      email: 'michael@gmail.com',
      avatarUrl: 'https://picsum.photos/420/320',
    ),
    User(
      id: '4',
      fullname: 'Sophia White',
      jobTitle: "Flutter Developer",
      username: 'sophia_w',
      email: 'sophia@gmail.com',
      avatarUrl: 'https://picsum.photos/400/400',
    ),
    User(
      id: '5',
      fullname: 'David Wilson',
      jobTitle: "Flutter Developer",
      username: 'david_w',
      email: 'david@gmail.com',
      avatarUrl: 'https://picsum.photos/450/300',
    ),
    User(
      id: '6',
      fullname: 'Olivia Lee',
      jobTitle: "Flutter Developer",
      username: 'olivia_lee',
      email: 'olivia@gmail.com',
      avatarUrl: 'https://picsum.photos/380/330',
    ),
    User(
      id: '7',
      fullname: 'Chris Martin',
      jobTitle: "Flutter Developer",
      username: 'chris_m',
      email: 'chris@gmail.com',
      avatarUrl: 'https://picsum.photos/400/350',
    ),
    User(
      id: '8',
      fullname: 'Isabella Harris',
      jobTitle: "Flutter Developer",
      username: 'isabella_h',
      email: 'isabella@gmail.com',
      avatarUrl: 'https://picsum.photos/370/340',
    ),
    User(
      id: '9',
      fullname: 'James Clark',
      jobTitle: "Flutter Developer",
      username: 'james_c',
      email: 'james@gmail.com',
      avatarUrl: 'https://picsum.photos/430/300',
    ),
    User(
      id: '10',
      fullname: 'Mia Anderson',
      jobTitle: "Flutter Developer",
      username: 'mia_a',
      email: 'mia@gmail.com',
      avatarUrl: 'https://picsum.photos/400/310',
    ),
    User(
      id: '11',
      fullname: 'Ethan Walker',
      jobTitle: "Flutter Developer",
      username: 'ethan_w',
      email: 'ethan@gmail.com',
      avatarUrl: 'https://picsum.photos/420/380',
    ),
    User(
      id: '12',
      fullname: 'Ava Taylor',
      jobTitle: "Flutter Developer",
      username: 'ava_t',
      email: 'ava@gmail.com',
      avatarUrl: 'https://picsum.photos/360/390',
    ),
    User(
      id: '13',
      fullname: 'Liam Thompson',
      jobTitle: "Flutter Developer",
      username: 'liam_t',
      email: 'liam@gmail.com',
      avatarUrl: 'https://picsum.photos/410/310',
    ),
    User(
      id: '14',
      fullname: 'Charlotte Miller',
      jobTitle: "Flutter Developer",
      username: 'charlotte_m',
      email: 'charlotte@gmail.com',
      avatarUrl: 'https://picsum.photos/380/360',
    ),
    User(
      id: '15',
      fullname: 'Lucas Moore',
      jobTitle: "Flutter Developer",
      username: 'lucas_m',
      email: 'lucas@gmail.com',
      avatarUrl: 'https://picsum.photos/400/320',
    ),
  ];
  late List<User> filteredMembers = allMembers;

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
