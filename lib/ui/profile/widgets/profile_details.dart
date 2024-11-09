import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/extensions/index.dart';
import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/widgets/index.dart';
import '../../screens.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({
    super.key,
    this.isMyProfile = false,
  });

  final bool isMyProfile;

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  bool _isEditing = false;

  late final TextEditingController _fullNameController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _emailController;
  late final TextEditingController _usernameController;

  @override
  void initState() {
    super.initState();
    final user = context.read<AuthManager>().loggedInUser!;
    _fullNameController = TextEditingController(text: user.fullname);
    _jobTitleController = TextEditingController(text: user.jobTitle);
    _emailController = TextEditingController(text: user.email);
    _usernameController = TextEditingController(text: user.username);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _jobTitleController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _saveInfo() {
    final newUserInfo = User(
      id: context.read<AuthManager>().loggedInUser!.id,
      fullname: _fullNameController.text,
      jobTitle: _jobTitleController.text,
      email: _emailController.text,
      username: _usernameController.text,
    );
    context.executeWithErrorHandling(() async {
      context.read<AuthManager>().updateUserInfo(newUserInfo);
    });
    _isEditing = false;
    setState(() {});
  }

  void _cancelEdit() {
    _isEditing = false;
    setState(() {});
  }

  void _editProfile() {
    _isEditing = true;
    setState(() {});
  }

  void _changePassword() {
    Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = Theme.of(context).colorScheme.primary;
    final Color inactiveColor =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full name field
        BlockTextField(
          labelText: 'Full Name',
          controller: _fullNameController,
          enabled: _isEditing,
          prefixIcon: Icon(Icons.person,
              color: _isEditing ? activeColor : inactiveColor),
        ),
        const SizedBox(height: 10),

        // Job title field
        BlockTextField(
          labelText: 'Job Title',
          controller: _jobTitleController,
          enabled: _isEditing,
          prefixIcon:
              Icon(Icons.work, color: _isEditing ? activeColor : inactiveColor),
        ),
        const SizedBox(height: 10),

        // Email field
        BlockTextField(
          labelText: 'Email',
          controller: _emailController,
          enabled: _isEditing,
          prefixIcon: Icon(Icons.email,
              color: _isEditing ? activeColor : inactiveColor),
        ),
        const SizedBox(height: 10),

        // Username field
        BlockTextField(
          labelText: 'Username',
          controller: _emailController,
          enabled: _isEditing,
          prefixIcon: Icon(Icons.person_pin,
              color: _isEditing ? activeColor : inactiveColor),
        ),

        if (widget.isMyProfile && _isEditing) ...[
          const SizedBox(height: 40),
          // Save button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveInfo,
              child: const Text('Save'),
            ),
          ),

          // Cancel button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: _cancelEdit,
              child: const Text('Cancel'),
            ),
          ),
        ] else if (widget.isMyProfile && !_isEditing) ...[
          const SizedBox(height: 40),
          // Edit button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _editProfile,
              child: const Text('Edit Profile'),
            ),
          ),

          // Change password button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('Change Password'),
            ),
          ),
        ],
      ],
    );
  }
}
