import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import './index.dart';

class InviteFriendsBar extends StatefulWidget {
  const InviteFriendsBar({this.isPopup = false, super.key});

  final bool isPopup;
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
    if (widget.isPopup) {
      return TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: child,
          );
        },
        child: _buildPopupDialog(context),
      );
    } else {
      return _buildPopupDialog(context);
    }
  }

  Widget _buildPopupDialog(BuildContext context) {
    return Dialog(
      shadowColor: Theme.of(context).colorScheme.onSurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    Icons.lightbulb,
                    color: Colors.yellow,
                    size: 30.0,
                    shadows: [
                      BoxShadow(
                        color: Colors.yellow,
                        blurRadius: 10.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.5, 0.5),
                      )
                    ],
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'The more people there are, the more minds come together',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              DropdownSearch<User>.multiSelection(
                dropdownBuilder: (context, selectedItems) {
                  if (selectedItems.isEmpty) {
                    return const Text("Invite your collaborators");
                  }
                  return Wrap(
                    children: selectedItems.map((user) {
                      return ColabChip(
                          username: user.userName,
                          onDeleted: () => setState(() => selectedItems.remove(
                              user))); // Hiển thị tên người dùng đã chọn
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
                  showSelectedItems: false,
                  dialogProps: DialogProps(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                      elevation: 20.0,
                      shadowColor: Theme.of(context)
                          .colorScheme
                          .surface
                          .withOpacity(0.3),
                      alignment: Alignment.topCenter,
                      contentPadding: const EdgeInsets.all(20.0)),
                  itemBuilder: userModelPopupItem,
                ),
                decoratorProps: DropDownDecoratorProps(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.people),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.transparent.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.all(8.0))),
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    //TODO: Invite friends action
                  },
                  child: const Text('Invite'),
                ),
              )
            ],
          ),
        ),
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
      child: Chip(onDeleted: onDeleted, label: Text(username)),
    );
  }
}
