import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import './index.dart';

class InviteMembersBar extends StatefulWidget {
  const InviteMembersBar(
      {this.isPopup = false,
      super.key,
      required this.selectedUsers,
      required this.onSelectedMembersChanged});

  final List<User> selectedUsers;
  final bool isPopup;
  final void Function(List<User>) onSelectedMembersChanged;

  @override
  State<InviteMembersBar> createState() => _MemberSearchBarState();
}

class _MemberSearchBarState extends State<InviteMembersBar> {
  void _updateSelectedMembers() {
    widget.onSelectedMembersChanged(widget.selectedUsers);
  }

  List<User> _filterMembers(BuildContext context, String filter) {
    if (filter.isEmpty) {
      return context.read<UsersManager>().getAll();
    } else {
      return context
          .read<UsersManager>()
          .getAll()
          .where((user) =>
              user.username.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }
  }

  void _onDeleted(User user) {
    widget.selectedUsers.remove(user);
    setState(() {});
  }

  void _onAdded(BuildContext context, List<User> selectedUsers) {
    widget.selectedUsers.clear();
    widget.selectedUsers.addAll(selectedUsers);
    _updateSelectedMembers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<UsersManager>().fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return getLoadingAnimation(context);
          }
          return DropdownSearch<User>.multiSelection(
            mode: Mode.form,
            dropdownBuilder: (context, selectedItems) =>
                _buildSelectedUsers(selectedItems),
            compareFn: (item1, item2) => item1.id == item2.id,
            items: (filter, loadProps) => _filterMembers(context, filter),
            selectedItems: [...widget.selectedUsers],
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
        });
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
