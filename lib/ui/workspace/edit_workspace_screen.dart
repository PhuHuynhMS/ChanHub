import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../../common/enums.dart';
import '../../models/index.dart';
import '../shared/utils/index.dart';
import '../shared/extensions/index.dart';
import '../shared/widgets/index.dart';

class EditWorkspaceScreen extends StatefulWidget {
  static const String routeName = '/edit-workspace-screen';

  const EditWorkspaceScreen(this.workspace, {super.key});

  final Workspace workspace;

  @override
  State<EditWorkspaceScreen> createState() => _EditWorkspaceScreenState();
}

class _EditWorkspaceScreenState extends State<EditWorkspaceScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Workspace _editedWorkspace;

  @override
  void initState() {
    _editedWorkspace = widget.workspace;
    super.initState();
  }

  void _onContinue(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    context.executeWithErrorHandling(() async {
      await context.read<WorkspacesManager>().updateWorkspace(_editedWorkspace);
    });

    if (context.mounted) {
      Navigator.of(context).pop();
    }
  }

  Widget _buildWorkspaceNameField() {
    return CustomizedTextField(
      initialValue: _editedWorkspace.name,
      validator: Validator.compose([
        Validator.minLength(6, 'Workspace name must be at least 6 characters'),
        Validator.maxLength(15, 'Workspace name must be at most 15 characters')
      ]),
      labelText: 'Workspace Name',
      hintText: 'Eg. Acme Co.',
      onSaved: (value) {
        _editedWorkspace = _editedWorkspace.copyWith(name: value);
        return null;
      },
    );
  }

  Widget _buildWorkspacePreview() {
    return Column(
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade300),
              ),
              child: _editedWorkspace.image == null
                  ? Image.network(
                      _editedWorkspace.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      _editedWorkspace.image!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildImagePickerButton(),
      ],
    );
  }

  TextButton _buildImagePickerButton() {
    return TextButton.icon(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      icon: const Icon(Icons.camera_alt_outlined, color: Colors.blueAccent),
      label: const Text(
        'Choose Image',
        style: TextStyle(color: Colors.blueAccent),
      ),
      onPressed: () async {
        final imagePicker = ImagePicker();
        try {
          final imageFile = await imagePicker.pickImage(
            source: ImageSource.gallery,
          );
          if (imageFile == null) {
            return;
          }
          _editedWorkspace =
              _editedWorkspace.copyWith(image: File(imageFile.path));
          setState(() {});
        } catch (error) {
          if (mounted) {
            showInfoDialog(
              confirmText: 'Something went wrong',
              context: context,
              status: StatusType.error,
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Workspace'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'Edit Workspace Details',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade700,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),

                  // Image preview section
                  _buildWorkspacePreview(),
                  const SizedBox(height: 30),

                  // Input field section
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildWorkspaceNameField(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Next button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => _onContinue(context),
                      child: const Text('Update'),
                    ),
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
