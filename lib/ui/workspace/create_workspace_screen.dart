import 'dart:io';

import 'package:flutter/material.dart';

import '../shared/utils/index.dart';
import '../shared/widgets/index.dart';
import '../screens.dart';

class CreateWorkspaceScreen extends StatefulWidget {
  static const String routeName = '/workspace/create';

  const CreateWorkspaceScreen({super.key});

  @override
  State<CreateWorkspaceScreen> createState() => _CreateWorkspaceScreenState();
}

class _CreateWorkspaceScreenState extends State<CreateWorkspaceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  File? _image;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }

  void _onContinue() {
    if (!_formKey.currentState!.validate() || _image == null) {
      return;
    }
    Navigator.of(context).pushNamed(
      AddWorkspaceMembersScreen.routeName,
      arguments: {
        'workspaceName': _nameController.text,
        'image': _image,
        'isCreating': true,
      },
    );
  }

  Widget _buildWorkspaceImagePreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 150,
          height: 150,
          margin: const EdgeInsets.only(top: 8, right: 10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          child: _image == null
              ? const Text(
                  'Workspace image',
                  textAlign: TextAlign.center,
                )
              : ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        const Spacer(),
        SizedBox(
          child: _buildImagePickerButton(),
        )
      ],
    );
  }

  TextButton _buildImagePickerButton() {
    return TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Pick Image'),
      onPressed: () async {
        _image = await showImagePicker(context);
        setState(() {});
      },
    );
  }

  Widget _buildWorkspaceNameField() {
    return CustomizedTextField(
      controller: _nameController,
      validator: Validator.compose([
        Validator.minLength(6, 'Name must be at least 6 characters'),
        Validator.maxLength(30, 'Name must be at most 30 characters')
      ]),
      labelText: 'Workspace Name',
      hintText: 'Eg. Acme Co.',
    );
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
            child: Form(
              key: _formKey,
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
                  _buildWorkspaceNameField(),
                  _buildWorkspaceImagePreview(),
                  // Next button
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onContinue,
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
      ),
    );
  }
}
