import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/enums.dart';
import '../../managers/index.dart';
import '../../models/index.dart';
import '../shared/extensions/index.dart';
import '../shared/widgets/index.dart';
import '../shared/utils/index.dart';

class EditChannelScreen extends StatefulWidget {
  static const String routeName = '/channel/edit';

  const EditChannelScreen(this.channel, {super.key});

  final Channel channel;

  @override
  State<EditChannelScreen> createState() => _EditChannelScreenState();
}

class _EditChannelScreenState extends State<EditChannelScreen> {
  final _formKey = GlobalKey<FormState>();
  late Channel _editedChannel = widget.channel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Channel'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'assets/images/edit_channel.png',
                    fit: BoxFit.cover,
                    height: 150.0,
                  ),
                  const SizedBox(height: 20.0),
                  Row(children: [
                    Text(
                      'Channel Information',
                      style: Theme.of(context).textTheme.titleMedium,
                    )
                  ]),
                  const SizedBox(height: 10.0),
                  _buildChannelNameField(),
                  const SizedBox(height: 15.0),
                  _buildChannelDescriptionField(),
                  _buildChannelPrivacySwitch(),
                  Text(
                    'You cannot change the privacy mode of a channel once it is created.',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 10.0),
                  _buildUpdateButton(),
                  _buildDeleteButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChannelNameField() {
    return CustomizedTextField(
      initialValue: _editedChannel.name,
      labelText: 'Channel Name',
      hintText: 'Enter channel name',
      validator: Validator.compose([
        Validator.required('Channel name is required'),
        Validator.minLength(6, 'Channel name must be at least 6 characters'),
        Validator.maxLength(20, 'Channel name must be at most 20 characters')
      ]),
      onSaved: (value) => _editedChannel = _editedChannel.copyWith(name: value),
    );
  }

  Widget _buildChannelDescriptionField() {
    return CustomizedTextField(
      initialValue: _editedChannel.description,
      labelText: 'Channel Description',
      hintText: 'Enter channel description',
      maxLength: 300,
      maxLines: 4,
      validator: Validator.compose([
        Validator.maxLength(
            300, 'Channel description must be at most 300 characters')
      ]),
      onSaved: (value) =>
          _editedChannel = _editedChannel.copyWith(description: value),
    );
  }

  Widget _buildChannelPrivacySwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Privacy mode', style: Theme.of(context).textTheme.titleMedium),
        Transform.scale(
            scale: 0.7,
            child: Switch(
              value: _editedChannel.privacy == ChannelPrivacy.private,
              onChanged: null,
            ))
      ],
    );
  }

  Widget _buildUpdateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onUpdateChannel,
        child: const Text('Save'),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onDeleteChannel,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.error,
        ),
        child: const Text('Delete'),
      ),
    );
  }

  void _onUpdateChannel() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    context.executeWithErrorHandling(() async {
      await context.read<ChannelsManager>().updateChannel(_editedChannel);

      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  void _onDeleteChannel() async {
    final isConfirmed = await showConfirmDialog(
      context: context,
      title: 'Delete channel',
      content: 'Are you sure you want to delete this channel?',
    );

    if (!isConfirmed) {
      return;
    }

    if (mounted) {
      context.executeWithErrorHandling(() async {
        Navigator.of(context).popUntil((route) => route.isFirst);
        await context.read<ChannelsManager>().deleteChannel(_editedChannel);
      });
    }
  }
}
