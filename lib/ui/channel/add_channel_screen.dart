import 'package:flutter/material.dart';

import '../shared/widget/customized_text_field.dart';

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

  void onAddChannel() {
    if (_globalKey.currentState!.validate()) {
      //TODO: Submit channel info
      print('Add Channel');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Channel',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  //tilte image
                  Image.asset(
                    'assets/images/channel_logo.png',
                    fit: BoxFit.cover,
                    height: 200.0,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // Channel name
                  CustomizedTextField(
                    labelText: 'Channel Name',
                    hintText: 'Enter channel name',
                    validator: _channelNameValidator,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  // Channel description
                  const CustomizedTextField(
                    labelText: 'Channel Description',
                    hintText: 'Enter channel description',
                    maxLength: 300,
                    maxLines: 2,
                  ),

                  const EncapsulatedSwitch(),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 40.0,
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: onAddChannel,
                        child: const Text(
                          'Create',
                        )),
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
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Privacy mode',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
            ),
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
        ),
        Text(
          'When this mode is activated, you can control who can view and interact with your channel\'s content.',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
              ),
        ),
      ],
    );
  }
}
