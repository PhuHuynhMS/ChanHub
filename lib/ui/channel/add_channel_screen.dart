import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/enums.dart';
import '../../managers/index.dart';
import '../../models/index.dart';
import '../shared/utils/index.dart';
import '../shared/widgets/index.dart';
import '../shared/extensions/index.dart';

class AddChannelScreen extends StatefulWidget {
  static const String routeName = '/channel/add';

  const AddChannelScreen({
    super.key,
  });

  @override
  State<AddChannelScreen> createState() => _AddChannelScreenState();
}

class _AddChannelScreenState extends State<AddChannelScreen> {
  final _formKey = GlobalKey<FormState>();
  late Channel _editedChannel;

  @override
  void initState() {
    super.initState();
    _editedChannel = Channel(
      name: '',
      description: '',
      privacy: ChannelPrivacy.public,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Channel'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Tilte image
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    height: 200.0,
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
                  const SizedBox(height: 10.0),
                  _buildChannelDescriptionField(),
                  _buildChannelPrivacySwitch(),

                  Text(
                    'When this mode is activated, you can control who can view and interact with your channel\'s content.',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 10.0),
                  _buildSubmitButton(),
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
              onChanged: (value) => setState(() {
                    _editedChannel = _editedChannel.copyWith(
                        privacy: value
                            ? ChannelPrivacy.private
                            : ChannelPrivacy.public);
                  })),
        )
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _onAddChannel,
        child: const Text('Create'),
      ),
    );
  }

  void _onAddChannel() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    context.executeWithErrorHandling(() async {
      await context.read<ChannelsManager>().createChannel(_editedChannel);

      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }
}
