import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import './index.dart';

class InviteMembersBar extends StatefulWidget {
  const InviteMembersBar({this.isPopup = false, super.key});

  final bool isPopup;
  @override
  State<InviteMembersBar> createState() => _MemberSearchBarState();
}

class _MemberSearchBarState extends State<InviteMembersBar> {
  final List<User> _users = [
    User(
      id: '1',
      fullname: 'John Smith',
      username: 'john_smith',
      jobTitle: 'Software Engineer',
      email: 'johnsmith@gmail.com',
      avatarUrl: 'https://picsum.photos/400/300',
    ),
    User(
      id: '2',
      fullname: 'Emily Brown',
      username: 'emily_brown',
      jobTitle: 'Product Designer',
      email: 'emily@gmail.com',
      avatarUrl: 'https://picsum.photos/350/300',
    ),
    User(
      id: '3',
      fullname: 'Michael Johnson',
      username: 'michael_j',
      jobTitle: 'Data Analyst',
      email: 'michael@gmail.com',
      avatarUrl: 'https://picsum.photos/420/320',
    ),
    User(
      id: '4',
      fullname: 'Sophia White',
      username: 'sophia_w',
      jobTitle: 'Marketing Manager',
      email: 'sophia@gmail.com',
      avatarUrl: 'https://picsum.photos/400/400',
    ),
    User(
      id: '5',
      fullname: 'David Wilson',
      username: 'david_w',
      jobTitle: 'Product Manager',
      email: 'david@gmail.com',
      avatarUrl: 'https://picsum.photos/450/300',
    ),
    User(
      id: '6',
      fullname: 'Olivia Lee',
      username: 'olivia_lee',
      jobTitle: 'UX Designer',
      email: 'olivia@gmail.com',
      avatarUrl: 'https://picsum.photos/380/330',
    ),
    User(
      id: '7',
      fullname: 'Chris Martin',
      username: 'chris_m',
      jobTitle: 'Software Engineer',
      email: 'chris@gmail.com',
      avatarUrl: 'https://picsum.photos/400/350',
    ),
    User(
      id: '8',
      fullname: 'Isabella Harris',
      username: 'isabella_h',
      jobTitle: 'Data Analyst',
      email: 'isabella@gmail.com',
      avatarUrl: 'https://picsum.photos/370/340',
    ),
    User(
      id: '9',
      fullname: 'James Clark',
      username: 'james_c',
      jobTitle: 'Product Manager',
      email: 'james@gmail.com',
      avatarUrl: 'https://picsum.photos/430/300',
    ),
    User(
      id: '10',
      fullname: 'Mia Anderson',
      username: 'mia_a',
      jobTitle: 'UX Designer',
      email: 'mia@gmail.com',
      avatarUrl: 'https://picsum.photos/400/310',
    ),
    User(
      id: '11',
      fullname: 'Ethan Walker',
      username: 'ethan_w',
      jobTitle: 'Software Engineer',
      email: 'ethan@gmail.com',
      avatarUrl: 'https://picsum.photos/420/380',
    ),
    User(
      id: '12',
      fullname: 'Ava Taylor',
      username: 'ava_t',
      jobTitle: 'Product Designer',
      email: 'ava@gmail.com',
      avatarUrl: 'https://picsum.photos/360/390',
    ),
    User(
      id: '13',
      fullname: 'Liam Thompson',
      username: 'liam_t',
      jobTitle: 'Data Analyst',
      email: 'liam@gmail.com',
      avatarUrl: 'https://picsum.photos/410/310',
    ),
    User(
      id: '14',
      fullname: 'Charlotte Miller',
      username: 'charlotte_m',
      jobTitle: 'Marketing Manager',
      email: 'charlotte@gmail.com',
      avatarUrl: 'https://picsum.photos/380/360',
    ),
    User(
      id: '15',
      fullname: 'Lucas Moore',
      username: 'lucas_m',
      jobTitle: 'Product Manager',
      email: 'lucas@gmail.com',
      avatarUrl: 'https://picsum.photos/400/320',
    ),
  ];
  final List<User> _selectedUsers = [];

  List<User> _filterMembers(String filter) {
    if (filter.isEmpty) {
      return _users;
    } else {
      return _users
          .where((user) =>
              user.username.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }
  }

  void _onDeleted(User user) {
    _selectedUsers.remove(user);
    setState(() {});
  }

  void _onAdded(BuildContext context, List<User> selectedUsers) {
    _selectedUsers.clear();
    _selectedUsers.addAll(selectedUsers);
    setState(() {});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<User>.multiSelection(
      mode: Mode.form,
      dropdownBuilder: (context, selectedItems) =>
          _buildSelectedUsers(selectedItems),
      compareFn: (item1, item2) => item1.id == item2.id,
      items: (filter, loadProps) => _filterMembers(filter),
      selectedItems: [..._selectedUsers],
      decoratorProps: DropDownDecoratorProps(
        decoration: outlinedInputDecoration(
          context,
          'Invite your collaborators',
          prefixIcon: const Icon(Icons.person_add),
        ),
      ),

      // Popup
      popupProps: PopupPropsMultiSelection.dialog(
        validationBuilder: (context, selectedItems) =>
            _buildInviteButton(selectedItems),
        disableFilter: true,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: underlineInputDecoration(
            context,
            'Search for members',
            prefixIcon: const Icon(Icons.search),
          ),
        ),
        dialogProps: const DialogProps(
          alignment: Alignment.center,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          insetPadding: EdgeInsets.all(20.0),
        ),
        itemBuilder: _userModelPopupItem,
      ),
    );
  }

  Widget _buildInviteButton(List<User> selectedUsers) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => _onAdded(context, selectedUsers),
          child: const Text("Add"),
        ),
      ),
    );
  }

  Widget _buildSelectedUsers(List<User> users) {
    return Wrap(
      children: users.map((user) {
        return ColabChip(
          username: user.username,
          onDeleted: () => _onDeleted(user),
        );
      }).toList(),
    );
  }

  Widget _userModelPopupItem(
      BuildContext context, User user, bool isSelected, bool isDisabled) {
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 10.0),
      title: Text(user.fullname),
      subtitle: Text(user.email, style: Theme.of(context).textTheme.labelSmall),
      leading: UserAvatar(user),
      trailing: isSelected ? const Icon(Icons.check) : null,
    );
  }
}

class ColabChip extends StatelessWidget {
  const ColabChip({
    required this.username,
    required this.onDeleted,
    super.key,
  });

  final void Function() onDeleted;
  final String username;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Wrap(
        children: <Widget>[
          Chip(onDeleted: onDeleted, label: Text(username)),
          const SizedBox(width: 5.0),
        ],
      ),
    );
  }
}
