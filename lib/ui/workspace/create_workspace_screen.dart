import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

  late File? image;

  @override
  void initState() {
    image = null;
    super.initState();
  }

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
      final name = _nameController.text;
      Navigator.of(context).pushNamed(AddWorkspaceMembersScreen.routeName,
          arguments: {'workspace_name': name, 'image': image});
    }
  }

  bool _isValid() {
    if (_isValidName && image != null) {
      return true;
    }
    return false;
  }

  String? _nameValidator(String? value) {
    if (value == null || value.trim().length < 6) {
      return 'Workspace name must be at least 6 characters long';
    } else if (value.trim().length > 15) {
      return 'Workspace name must be at most 15 characters long';
    }
    return null;
  }

  Widget _buildProductPreview() {
    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
          alignment: Alignment.center,
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(top: 8, right: 10),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: image == null
              ? const Text(
                  'Add your workspace avatar',
                  textAlign: TextAlign.center,
                )
              : Image.file(
                  image!,
                  fit: BoxFit.cover,
                )),
      Expanded(
        child: SizedBox(
          height: 100,
          child: _buildImagePickerButton(),
        ),
      )
    ]);
  }

  TextButton _buildImagePickerButton() {
    return TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Pick Image'),
      onPressed: () async {
        final imagePicker = ImagePicker();
        try {
          final imageFile = await imagePicker.pickImage(
            source: ImageSource.gallery,
          );
          if (imageFile == null) {
            return;
          }
          image = File(imageFile.path);
          setState(() {});
        } catch (error) {
          if (mounted) {
            print('Error');
          }
        }
      },
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
                _buildProductPreview(),
                // Next button
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isValid() ? _onContinue : null,
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
