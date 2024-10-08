import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../models/index.dart';
import './index.dart';

// FIXME: This is a temporary solution to the issue of the User model not being available
class InviteFriendsBar extends StatefulWidget {
  const InviteFriendsBar({super.key});

  @override
  State<InviteFriendsBar> createState() => _FriendSearchBarState();
}

class _FriendSearchBarState extends State<InviteFriendsBar> {
  final List<User> friends = [
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '2',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '3',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '4',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '5',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '6',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '7',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '8',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '9',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '10',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '11',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '12',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '13',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '14',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '15',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '5',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '5',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '5',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '5',
      fullName: 'John Doe',
      userName: 'mrTeo',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
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
        dropdownBuilder: (context, selectedItems) {
          if (selectedItems.isEmpty) {
            return const Text("Invite your collaborators");
          }
          return Wrap(
            children: selectedItems.map((user) {
              return ColabChip(
                  username: user.userName,
                  onDeleted: () => setState(() => selectedItems.remove(user)));
            }).toList(),
          );
        },
        compareFn: (item1, item2) => item1.id == item2.id,
        items: (filter, loadProps) {
          return _filterFriends(filter);
        },
        popupProps: PopupPropsMultiSelection.dialog(
          disableFilter: true,
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            padding: const EdgeInsets.only(bottom: 5.0),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Search for your friend's username",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onChanged: (value) {
              setState(() {
                fiteredFriends = _filterFriends(value);
              });
            },
          ),
          showSelectedItems: false,
          dialogProps: const DialogProps(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              alignment: Alignment.center,
              contentPadding: EdgeInsets.all(20.0)),
          itemBuilder: userModelPopupItem,
        ),
        decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.people),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.transparent.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.all(8.0))),
      ),
    );
  }
}

Widget userModelPopupItem(
    BuildContext context, User user, bool isSelected, bool isDisabled) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0, right: 0.0, left: 0.0),
    child: ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      title: Text(
        user.userName,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      leading: UserAvatar(user),
      trailing: isSelected ? const Icon(Icons.check) : null,
    ),
  );
}

class ColabChip extends StatelessWidget {
  const ColabChip({required this.username, required this.onDeleted, super.key});

  final void Function() onDeleted;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Chip(
          side: const BorderSide(
            color: Colors.transparent,
          ),
          deleteIconBoxConstraints:
              const BoxConstraints.expand(width: 20.0, height: 20.0),
          deleteIcon: const Icon(
            Icons.close,
          ),
          padding: const EdgeInsets.only(left: 5.0),
          labelPadding: const EdgeInsets.only(right: 5.0),
          deleteIconColor: Theme.of(context).colorScheme.error,
          onDeleted: onDeleted,
          backgroundColor:
              Theme.of(context).colorScheme.tertiary.withOpacity(0.4),
          label: Text(username, style: Theme.of(context).textTheme.bodyMedium)),
    );
  }
}
