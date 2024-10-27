import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../shared/extensions/index.dart';
import '../../shared/widgets/index.dart';
import '../../shared/utils/index.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
  });

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              _buildEmailField(),
              const SizedBox(height: 10.0),
              Text(
                'A link to reset your password will be sent to your email',
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              _buildSubmitButton(),
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

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _submitForm,
        child: const Text('Reset Password'),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    await context.executeWithErrorHandling(() async {
      await context.read<AuthManager>().resetPassword(_formData['email']);
    });

    if (mounted) {
      showSuccessSnackBar(
        context: context,
        message: 'Password reset link sent',
      );
      Navigator.of(context).pop();
    }
  }
}
