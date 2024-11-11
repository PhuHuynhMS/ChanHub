import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/widgets/index.dart';

class InviteMembersBar extends StatelessWidget {
  const InviteMembersBar({
    super.key,
    required this.selectedUsers,
    required this.onSelectedMembersChanged,
  });

  final List<User> selectedUsers;
  final void Function(List<User>) onSelectedMembersChanged;

  Future<List<User>> _filterMembers(
      BuildContext context, String filter, List<User> members) async {
    final users = await context.read<UsersManager>().searchUsers(filter);
    return users
        .where((user) => !members.any((member) => member.id == user.id))
        .toList();
  }

  void _onDeleted(User user) {
    selectedUsers.remove(user);
    onSelectedMembersChanged(selectedUsers);
  }

  void _onAdded(BuildContext context, List<User> selectedUsers) {
    selectedUsers.addAll(
      selectedUsers
          .where((user) =>
              !selectedUsers.any((selectedUser) => selectedUser.id == user.id))
          .toList(),
    );
    onSelectedMembersChanged(selectedUsers);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final workspaceMembers =
        context.read<WorkspacesManager>().getSelectedWorkspace()!.members;
    final workspaceInvitations =
        context.read<WorkspacesManager>().getSelectedWorkspace()!.invitations;

    return DropdownSearch<User>.multiSelection(
      mode: Mode.form,
      dropdownBuilder: (context, selectedItems) =>
          _buildSelectedUsers(selectedItems),
      compareFn: (item1, item2) => item1.id == item2.id,
      items: (filter, loadProps) =>
          _filterMembers(context, filter, workspaceMembers),
      selectedItems: [...selectedUsers],
      decoratorProps: DropDownDecoratorProps(
        decoration: outlinedInputDecoration(
          context,
          'Invite your collaborators',
          prefixIcon: const Icon(Icons.person_add),
        ),
      ),

      // Popup
      popupProps: PopupPropsMultiSelection.dialog(
        validationBuilder: _buildInviteButton,
        disableFilter: true,
        showSearchBox: true,
        searchFieldProps: TextFieldProps(
          decoration: underlineInputDecoration(
            context,
            'Search for members',
            prefixIcon: const Icon(Icons.search),
          ),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        dialogProps: const DialogProps(
          alignment: Alignment.center,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          insetPadding: EdgeInsets.all(20),
        ),
        itemBuilder: _userModelPopupItem,
        disabledItemFn: (item) =>
            workspaceInvitations.any((user) => user.id == item.id),
        searchDelay: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget _buildInviteButton(BuildContext context, List<User> selectedUsers) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => _onAdded(context, selectedUsers),
          child: Text(selectedUsers.isEmpty ? 'Cancel' : 'Add'),
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
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: Wrap(
        children: <Widget>[
          Chip(onDeleted: onDeleted, label: Text(username)),
          const SizedBox(width: 5.0),
        ],
      ),
    );
  }
}
