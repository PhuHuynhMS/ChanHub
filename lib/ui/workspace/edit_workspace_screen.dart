import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../managers/index.dart';
import '../../models/index.dart';
import '../shared/utils/index.dart';
import '../shared/extensions/index.dart';
import '../shared/widgets/index.dart';

class EditWorkspaceScreen extends StatefulWidget {
  static const String routeName = '/workspace/edit';

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
      Navigator.of(context).popUntil((route) => route.isFirst);
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
    return Row(
      children: [
        Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _editedWorkspace.image == null
                ? Image.network(
                    width: 150,
                    height: 150,
                    _editedWorkspace.imageUrl!,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    width: 150,
                    height: 150,
                    _editedWorkspace.image!,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const Spacer(),
        _buildImagePickerButton(),
      ],
    );
  }

  TextButton _buildImagePickerButton() {
    return TextButton.icon(
      icon: const Icon(Icons.camera_alt_outlined),
      label: Text(
        'Choose Image',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      onPressed: () async {
        final image = await showImagePicker(context);
        _editedWorkspace = _editedWorkspace.copyWith(image: image);
        setState(() {});
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
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    'What\'s the updated of your company or team?',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30.0),

                  // Input field section
                  _buildWorkspaceNameField(),
                  const SizedBox(height: 20),

                  // Image preview section
                  _buildWorkspacePreview(),
                  const SizedBox(height: 20),

                  // Next button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
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
