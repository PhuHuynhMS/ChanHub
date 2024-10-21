import 'package:flutter/material.dart';

import '../../common/enums.dart';
import '../../models/index.dart';
import '../shared/widgets/index.dart';

class EditChannelScreen extends StatefulWidget {
  static const String routeName = '/edit_channel';

  const EditChannelScreen(this.channel, {super.key});

  final Channel channel;

  @override
  State<EditChannelScreen> createState() => _EditChannelScreenState();
}

class _EditChannelScreenState extends State<EditChannelScreen> {
  bool _isEditing = false;

  void _saveInfo() {
    //TODO: Update the channel
    _isEditing = false;
    setState(() {});
  }

  void _editProfile() {
    _isEditing = true;
    setState(() {});
  }

  void _cancelEdit() {
    _isEditing = false;
    setState(() {});
  }

  Widget _buildChannelNameField() {
    return CustomizedTextField(
      labelText: 'Channel Name',
      initialValue: widget.channel.name,
      readOnly: !_isEditing,
    );
  }

  Widget _buildChannelDescriptionField() {
    return CustomizedTextField(
      labelText: 'Channel Description',
      initialValue: widget.channel.description,
      maxLines: 5,
      readOnly: !_isEditing,
    );
  }

  Widget _buildSaveOrEditButton() {
    if (!_isEditing) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _editProfile();
              },
              child: const Text('Edit Channel'),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _saveInfo();
              },
              child: const Text('Save'),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: _cancelEdit,
              child: const Text('Cancel'),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Channel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildChannelNameField(),
            const SizedBox(height: 15.0),
            _buildChannelDescriptionField(),
            const SizedBox(height: 10.0),
            _buildSaveOrEditButton(),
          ],
        ),
      ),
    );
  }
}
