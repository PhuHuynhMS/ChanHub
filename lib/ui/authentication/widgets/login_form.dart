import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../shared/extensions/index.dart';
import '../../shared/widgets/index.dart';
import '../../shared/utils/index.dart';
import './index.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.toggleLoginRegister,
  });

  final void Function() toggleLoginRegister;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              // Background image
              const ShadowedTitle('Login'),
              const Text('Enter your email and password to login'),
              const SizedBox(height: 20),

              _buildEmailField(),
              const SizedBox(height: 10),

              _buildPasswordField(),

              // Forgot password button
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  onPressed: _showResetPasswordDialog,
                  child: Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                ),
              ),

              _buildSubmitButton(),

              // Register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: widget.toggleLoginRegister,
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return BlockTextField(
      labelText: 'Email',
      prefixIcon: const Icon(Icons.email),
      validator: Validator.compose([
        Validator.required('Email is required'),
        Validator.email('Invalid email address'),
      ]),
      onSaved: (value) => _formData['email'] = value,
    );
  }

  Widget _buildPasswordField() {
    return BlockTextField(
      labelText: 'Password',
      prefixIcon: const Icon(Icons.lock),
      obscureText: true,
      validator: Validator.compose([
        Validator.required('Password is required'),
        Validator.minLength(8, 'Password must be at least 8 characters'),
        Validator.maxLength(40, 'Password must be at most 20 characters'),
      ]),
      onSaved: (value) => _formData['password'] = value,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        child: const Text('Login'),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    context.executeWithErrorHandling(() async {
      await context.read<AuthManager>().login(
            email: _formData['email'],
            password: _formData['password'],
          );
    });
  }

  void _showResetPasswordDialog() {
    showActionDialog(
      context: context,
      title: "Forgot Password",
      content: const ResetPasswordForm(),
    );
  }
}
