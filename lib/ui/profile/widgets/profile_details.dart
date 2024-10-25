import 'package:flutter/material.dart';

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

  void _saveInfo() {
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
    final User user = User(
      id: '1',
      fullname: 'John Doe',
      jobTitle: 'Software Engineer',
      username: 'johndoe',
      email: 'john@gmail.com',
      avatarUrl: 'https://picsum.photos/420/380',
    );
    final Color activeColor = Theme.of(context).colorScheme.primary;
    final Color inactiveColor =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full name field
        BlockTextField(
          labelText: 'Full Name',
          initialValue: user.fullname,
          enabled: _isEditing,
          prefixIcon: Icon(Icons.person,
              color: _isEditing ? activeColor : inactiveColor),
        ),
        const SizedBox(height: 10),

        // Job title field
        BlockTextField(
          labelText: 'Job Title',
          initialValue: user.jobTitle,
          enabled: _isEditing,
          prefixIcon:
              Icon(Icons.work, color: _isEditing ? activeColor : inactiveColor),
        ),
        const SizedBox(height: 10),

        // Email field
        BlockTextField(
          labelText: 'Email',
          initialValue: user.email,
          enabled: _isEditing,
          prefixIcon: Icon(Icons.email,
              color: _isEditing ? activeColor : inactiveColor),
        ),
        const SizedBox(height: 10),

        // Username field
        BlockTextField(
          labelText: 'Username',
          initialValue: user.username,
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
