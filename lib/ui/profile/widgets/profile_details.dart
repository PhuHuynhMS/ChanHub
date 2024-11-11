import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/extensions/index.dart';
import '../../shared/widgets/index.dart';
import '../../shared/utils/index.dart';
import '../../screens.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails(
    this.user, {
    super.key,
  });

  final User user;

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  bool _isMyProfile = false;
  late User _editedUser;

  @override
  void initState() {
    super.initState();
    final loggedInUser = context.read<AuthManager>().loggedInUser!;
    _isMyProfile = loggedInUser.id == widget.user.id;

    _editedUser = widget.user.copyWith();
  }

  void _saveInfo() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final bool isConfirmed = await showConfirmDialog(
      context: context,
      title: 'Save Changes',
      content: 'Are you sure you want to save changes?',
    );

    if (!isConfirmed || !mounted) {
      return;
    }

    context.executeWithErrorHandling(() async {
      await context.read<AuthManager>().updateUserInfo(_editedUser);

      _isEditing = false;
      setState(() {});
      if (mounted) {
        showSuccessSnackBar(
            context: context, message: 'Profile updated successfully');
      }
    });
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFullnameField(context),
          const SizedBox(height: 10),
          _buildJobTitleField(context),
          const SizedBox(height: 10),
          _buildEmailField(context),
          const SizedBox(height: 10),
          _buildUsernameField(context),

          // Editing buttons
          if (_isMyProfile && _isEditing) ...[
            const SizedBox(height: 40),
            _buildSaveButton(context),
            _buildCancelButton(context),
          ],

          // Non-editing buttons
          if (_isMyProfile && !_isEditing) ...[
            const SizedBox(height: 40),
            _buildEditButton(context),
            _buildChangePasswordButton(context),
          ],
        ],
      ),
    );
  }

  Widget _buildFullnameField(BuildContext context) {
    return BlockTextField(
      labelText: 'Full Name',
      initialValue: _editedUser.fullname,
      enabled: _isEditing,
      validator: Validator.compose([
        Validator.required('Full name is required'),
        Validator.minLength(3, 'Full name must be at least 3 characters'),
        Validator.maxLength(50, 'Full name must be at most 50 characters'),
      ]),
      prefixIcon: Icon(
        Icons.person,
        color: _isEditing
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
      onSaved: (value) => _editedUser = _editedUser.copyWith(fullname: value),
    );
  }

  Widget _buildJobTitleField(BuildContext context) {
    return BlockTextField(
      labelText: 'Job Title',
      initialValue: _editedUser.jobTitle,
      enabled: _isEditing,
      validator: Validator.compose([
        Validator.maxLength(30, 'Job title must be at most 30 characters'),
      ]),
      prefixIcon: Icon(
        Icons.work,
        color: _isEditing
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
      onSaved: (value) => _editedUser = _editedUser.copyWith(jobTitle: value),
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return BlockTextField(
      labelText: 'Email',
      initialValue: _editedUser.email,
      enabled: false,
      prefixIcon: Icon(
        Icons.email,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }

  Widget _buildUsernameField(BuildContext context) {
    return BlockTextField(
      labelText: 'Username',
      initialValue: _editedUser.username,
      enabled: false,
      prefixIcon: Icon(
        Icons.person,
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _saveInfo,
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.error,
        ),
        onPressed: _cancelEdit,
        child: const Text('Cancel'),
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _editProfile,
        child: const Text('Edit Profile'),
      ),
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _changePassword,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.primary,
        ),
        child: const Text('Change Password'),
      ),
    );
  }
}
