import 'package:flutter/material.dart';

import '../shared/widgets/index.dart';
import '../screens.dart';

class CreateWorkspaceScreen extends StatefulWidget {
  static const String routeName = '/workspace_creation_screen';

  const CreateWorkspaceScreen({super.key});

  @override
  State<CreateWorkspaceScreen> createState() => _CreateWorkspaceScreenState();
}

class _CreateWorkspaceScreenState extends State<CreateWorkspaceScreen> {
  final _nameController = TextEditingController();
  bool isValidName = false;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void onInput(value) {
    setState(() {
      isValidName = value.toString().trim().length >= 6;
    });
  }

  void onContinue() {
    if (isValidName) {
      // TODO: Navigate to next screen
      Navigator.of(context).pushNamed(AddWorkspaceFriendsScreen.routeName);
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
        centerTitle: false,
        title: Text(
          'Create workspace',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                // Title
                Text(
                  'What\'s is the name of your company or team?',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontWeight: FontWeight.w900,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30.0),
                Text(
                  'This will be the name of your workspace',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 10.0),

                // Input field
                CustomizedTextField(
                  onChanged: onInput,
                  controller: _nameController,
                  validator: _nameValidator,
                  labelText: 'Workspace Name',
                  hintText: 'Eg. Acme Co.',
                ),

                // Next button
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(isValidName
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.3)),
                    ),
                    onPressed: isValidName ? onContinue : null,
                    child: const Text(
                      'Next',
                    ),
                  ),
                ),

                // Terms and conditions
                Text(
                  'By continuing, you\'re agreeing to our Main Services Agreement, User Terms of Service, and ChanHub Supplemental Terms. Additional disclosures are available in out Privacy Policy and Cookie Policy.',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.4)),
                  maxLines: 4,
                  softWrap: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
