import 'package:ct484_project/ui/authentication/login_or_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../shared/extensions/index.dart';
import '../shared/utils/index.dart';
import '../shared/widgets/index.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = '/profile/change-password';

  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final TextEditingController _currentPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _newPasswordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.executeWithErrorHandling(() async {
        await context.read<AuthManager>().updatePassword({
          'password': _newPasswordController.text,
          'passwordConfirm': _confirmPasswordController.text,
          'oldPassword': _currentPasswordController.text,
        });

        // if (context.mounted) {
        //   showInfoDialog(
        //     confirmText: 'Your password has been updated. Please log in again.',
        //     context: context,
        //   );

        //   Navigator.of(context)
        //       .pushReplacementNamed(LoginOrRegisterScreen.routeName);
        // }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlockTextField(
                labelText: 'Current Password',
                controller: _currentPasswordController,
                obscureText: true,
                validator: Validator.compose(
                  [
                    Validator.required('Please, enter your password'),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              BlockTextField(
                labelText: 'New Password',
                controller: _newPasswordController,
                obscureText: true,
                validator: Validator.compose(
                  [
                    Validator.required('Please, enter your new password'),
                    Validator.minLength(
                      8,
                      'Password must be at least 8 characters',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              BlockTextField(
                labelText: 'Confirm Password',
                controller: _confirmPasswordController,
                obscureText: true,
                validator: Validator.compose(
                  [
                    Validator.match(
                      _newPasswordController.text,
                      'Password do not match',
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => {_changePassword(context)},
                  child: const Text('Change Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
