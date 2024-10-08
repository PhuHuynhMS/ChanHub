import 'package:flutter/material.dart';

import '../shared/widgets/index.dart';
import '../screens.dart';

class CreateWorkspaceScreen extends StatefulWidget {
  static const String routeName = '/workspace/create';

  const CreateWorkspaceScreen({super.key});

  @override
  State<CreateWorkspaceScreen> createState() => _CreateWorkspaceScreenState();
}

class _CreateWorkspaceScreenState extends State<CreateWorkspaceScreen> {
  final _nameController = TextEditingController();
  bool _isValidName = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void _onInput(value) {
    _isValidName = value.toString().trim().length >= 6;
    setState(() {});
  }

  void _onContinue() {
    if (_isValidName) {
      // TODO: Navigate to next screen
      Navigator.of(context).pushNamed(AddWorkspaceMembersScreen.routeName);
    }
  }

  String? _nameValidator(String? value) {
    if (value == null || value.trim().length < 6) {
      return 'Workspace name must be at least 6 characters long';
    } else if (value.trim().length > 15) {
      return 'Workspace name must be at most 15 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create workspace'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Title
                Text(
                  'What\'s is the name of your company or team?',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                const Text('This will be the name of your workspace'),
                const SizedBox(height: 10.0),

                // Input field
                CustomizedTextField(
                  onChanged: _onInput,
                  controller: _nameController,
                  validator: _nameValidator,
                  labelText: 'Workspace Name',
                  hintText: 'Eg. Acme Co.',
                ),

                // Next button
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isValidName ? _onContinue : null,
                    child: const Text('Next'),
                  ),
                ),

                // Terms and conditions
                Text(
                  'By continuing, you\'re agreeing to our Main Services Agreement, User Terms of Service, and ChanHub Supplemental Terms. Additional disclosures are available in out Privacy Policy and Cookie Policy.',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
