import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import './index.dart';

class InviteFriendsBar extends StatefulWidget {
  const InviteFriendsBar({super.key});

  @override
  State<InviteFriendsBar> createState() => _FriendSearchBarState();
}

class _FriendSearchBarState extends State<InviteFriendsBar> {
  final List<User> friends = [
    User(
      id: '1',
      fullName: 'John Smith',
      userName: 'john_smith',
      email: 'johnsmith@gmail.com',
      avatarUrl: 'https://picsum.photos/400/300',
    ),
    User(
      id: '2',
      fullName: 'Emily Brown',
      userName: 'emily_brown',
      email: 'emily@gmail.com',
      avatarUrl: 'https://picsum.photos/350/300',
    ),
    User(
      id: '3',
      fullName: 'Michael Johnson',
      userName: 'michael_j',
      email: 'michael@gmail.com',
      avatarUrl: 'https://picsum.photos/420/320',
    ),
    User(
      id: '4',
      fullName: 'Sophia White',
      userName: 'sophia_w',
      email: 'sophia@gmail.com',
      avatarUrl: 'https://picsum.photos/400/400',
    ),
    User(
      id: '5',
      fullName: 'David Wilson',
      userName: 'david_w',
      email: 'david@gmail.com',
      avatarUrl: 'https://picsum.photos/450/300',
    ),
    User(
      id: '6',
      fullName: 'Olivia Lee',
      userName: 'olivia_lee',
      email: 'olivia@gmail.com',
      avatarUrl: 'https://picsum.photos/380/330',
    ),
    User(
      id: '7',
      fullName: 'Chris Martin',
      userName: 'chris_m',
      email: 'chris@gmail.com',
      avatarUrl: 'https://picsum.photos/400/350',
    ),
    User(
      id: '8',
      fullName: 'Isabella Harris',
      userName: 'isabella_h',
      email: 'isabella@gmail.com',
      avatarUrl: 'https://picsum.photos/370/340',
    ),
    User(
      id: '9',
      fullName: 'James Clark',
      userName: 'james_c',
      email: 'james@gmail.com',
      avatarUrl: 'https://picsum.photos/430/300',
    ),
    User(
      id: '10',
      fullName: 'Mia Anderson',
      userName: 'mia_a',
      email: 'mia@gmail.com',
      avatarUrl: 'https://picsum.photos/400/310',
    ),
    User(
      id: '11',
      fullName: 'Ethan Walker',
      userName: 'ethan_w',
      email: 'ethan@gmail.com',
      avatarUrl: 'https://picsum.photos/420/380',
    ),
    User(
      id: '12',
      fullName: 'Ava Taylor',
      userName: 'ava_t',
      email: 'ava@gmail.com',
      avatarUrl: 'https://picsum.photos/360/390',
    ),
    User(
      id: '13',
      fullName: 'Liam Thompson',
      userName: 'liam_t',
      email: 'liam@gmail.com',
      avatarUrl: 'https://picsum.photos/410/310',
    ),
    User(
      id: '14',
      fullName: 'Charlotte Miller',
      userName: 'charlotte_m',
      email: 'charlotte@gmail.com',
      avatarUrl: 'https://picsum.photos/380/360',
    ),
    User(
      id: '15',
      fullName: 'Lucas Moore',
      userName: 'lucas_m',
      email: 'lucas@gmail.com',
      avatarUrl: 'https://picsum.photos/400/320',
    ),
  ];

  List<User> _filterFriends(String filter) {
    if (filter.isEmpty) {
      return friends;
    } else {
      return friends
          .where((user) =>
              user.userName.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }
  }

  List<User> fiteredFriends = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DropdownSearch<User>.multiSelection(
        dropdownBuilder: (context, selectedItems) => Wrap(
          children: selectedItems.map((user) {
            return ColabChip(
                username: user.userName,
                onDeleted: () => setState(() => selectedItems.remove(user)));
          }).toList(),
        ),
        compareFn: (item1, item2) => item1.id == item2.id,
        items: (filter, loadProps) => _filterFriends(filter),
        popupProps: PopupPropsMultiSelection.dialog(
          disableFilter: true,
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: underlineInputDecoration(
              context,
              'Search for members',
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) {
              setState(() {
                fiteredFriends = _filterFriends(value);
              });
            },
          ),
          dialogProps: const DialogProps(
            alignment: Alignment.center,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            insetPadding: EdgeInsets.all(20.0),
          ),
          itemBuilder: userModelPopupItem,
        ),
        decoratorProps: DropDownDecoratorProps(
          decoration: outlinedInputDecoration(
            context,
            'Invite your collaborators',
            prefixIcon: const Icon(Icons.person_add),
          ),
        ),
      ),
    );
  }
}

Widget userModelPopupItem(
    BuildContext context, User user, bool isSelected, bool isDisabled) {
  return ListTile(
    contentPadding: const EdgeInsets.only(bottom: 10.0),
    title: Text(user.userName),
    leading: UserAvatar(user),
    trailing: isSelected ? const Icon(Icons.check) : null,
  );
}

class ColabChip extends StatelessWidget {
  const ColabChip({required this.username, required this.onDeleted, super.key});

  final void Function() onDeleted;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Chip(onDeleted: onDeleted, label: Text(username)),
        const SizedBox(width: 5.0),
      ],
    );
  }
}
