import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../shared/extensions/index.dart';
import '../../shared/widgets/index.dart';
import '../../shared/utils/index.dart';
import './index.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.toggleLoginRegister,
  });

  final void Function() toggleLoginRegister;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
              const ShadowedTitle('Register'),
              const Text('Let\'s get you started'),
              const SizedBox(height: 20),

              _buildEmailField(),
              const SizedBox(height: 10),

              _buildUsernameField(),
              const SizedBox(height: 10),

              _buildFullNameField(),
              const SizedBox(height: 10),

              _buildPasswordField(),
              const SizedBox(height: 10),

              _buildConfirmPasswordField(),
              const SizedBox(height: 10),

              _buildSubmitButton(),

              // Login button (With text)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('You have an account?'),
                  TextButton(
                    onPressed: widget.toggleLoginRegister,
                    child: const Text('Login'),
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
        Validator.email('Please enter a valid email address'),
      ]),
      onSaved: (value) => _formData['email'] = value?.trim(),
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
      ]),
      onSaved: (value) => _formData['password'] = value?.trim(),
      onChanged: _onPasswordChanged,
    );
  }

  Widget _buildConfirmPasswordField() {
    return BlockTextField(
      labelText: 'Confirm Password',
      prefixIcon: const Icon(Icons.lock),
      obscureText: true,
      validator: Validator.compose([
        Validator.required('Confirm password is required'),
        Validator.minLength(8, 'Password must be at least 8 characters'),
        Validator.match(
          _formData['password'],
          'Confirm password must match password',
        ),
      ]),
    );
  }

  Widget _buildUsernameField() {
    return BlockTextField(
      labelText: 'Username',
      prefixIcon: const Icon(Icons.person_pin),
      validator: Validator.compose([
        Validator.required('Username is required'),
        Validator.minLength(3, 'Username must be at least 3 characters'),
      ]),
      onSaved: (value) => _formData['username'] = value?.trim(),
    );
  }

  Widget _buildFullNameField() {
    return BlockTextField(
      labelText: 'Full Name',
      prefixIcon: const Icon(Icons.person),
      validator: Validator.compose([
        Validator.required('Full name is required'),
        Validator.minLength(3, 'Full name must be at least 3 characters'),
        Validator.maxLength(50, 'Full name must be at most 50 characters'),
      ]),
      onSaved: (value) => _formData['fullname'] = value,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        child: const Text('Register'),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    context.executeWithErrorHandling(() async {
      await context.read<AuthManager>().signup(
            email: _formData['email'],
            password: _formData['password'],
            username: _formData['username'],
            jobTitle: _formData['jobTitle'],
            fullname: _formData['fullname'],
          );

      _formKey.currentState!.reset();
      setState(() {});
      widget.toggleLoginRegister();

      if (mounted) {
        showSuccessSnackBar(
          context: context,
          message: 'An email has been sent to you for verification',
        );
      }
    });
  }

  void _onPasswordChanged(String? value) {
    _formData['password'] = value;
    setState(() {});
  }
}
