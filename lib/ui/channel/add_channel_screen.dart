import 'package:flutter/material.dart';

import '../shared/widgets/index.dart';

class AddChannelScreen extends StatefulWidget {
  static const String routeName = '/add-channel';

  const AddChannelScreen({super.key});

  @override
  State<AddChannelScreen> createState() => _AddChannelScreenState();
}

class _AddChannelScreenState extends State<AddChannelScreen> {
  final _globalKey = GlobalKey<FormState>();

  String? _channelNameValidator(String? value) {
    value = value.toString().trim();
    if (value.length < 6) {
      return 'Channel name must be at least 6 characters';
    } else if (value.length > 15) {
      return 'Channel name can not exceed 15 characters';
    } else {
      return null;
    }
  }

  void _onAddChannel() {
    if (_globalKey.currentState!.validate()) {
      //TODO: Submit channel info
      print('Add Channel');
    }
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
              key: _globalKey,
              child: Column(
                children: [
                  // Tilte image
                  Image.asset(
                    'assets/images/channel_logo.png',
                    fit: BoxFit.cover,
                    height: 200.0,
                  ),
                  const SizedBox(height: 20.0),

                  // Channel name
                  CustomizedTextField(
                    labelText: 'Channel Name',
                    hintText: 'Enter channel name',
                    validator: _channelNameValidator,
                  ),
                  const SizedBox(height: 10.0),

                  // Channel description
                  const CustomizedTextField(
                    labelText: 'Channel Description',
                    hintText: 'Enter channel description',
                    maxLength: 300,
                    maxLines: 2,
                  ),

                  // Privacy mode
                  const EncapsulatedSwitch(),
                  Text(
                    'When this mode is activated, you can control who can view and interact with your channel\'s content.',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 10.0),

                  // Create button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onAddChannel,
                      child: const Text('Create'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EncapsulatedSwitch extends StatefulWidget {
  const EncapsulatedSwitch({super.key});

  @override
  State<EncapsulatedSwitch> createState() => _EncapsulatedSwitchState();
}

class _EncapsulatedSwitchState extends State<EncapsulatedSwitch> {
  bool isPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Privacy mode', style: Theme.of(context).textTheme.titleMedium),
        Transform.scale(
          scale: 0.7,
          child: Switch(
              activeColor: Theme.of(context).colorScheme.primary,
              value: isPrivacy,
              onChanged: (value) {
                setState(() {
                  isPrivacy = value;
                });
              }),
        )
      ],
    );
  }
}
