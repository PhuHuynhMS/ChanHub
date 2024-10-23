import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/index.dart';
import '../shared/widgets/index.dart';
import '../shared/utils/index.dart';

class EditChannelScreen extends StatefulWidget {
  static const String routeName = '/edit_channel';

  const EditChannelScreen(this.channel, {super.key});

  final Channel channel;

  @override
  State<EditChannelScreen> createState() => _EditChannelScreenState();
}

class _EditChannelScreenState extends State<EditChannelScreen> {
  void _saveChannelInfo() {
    //TODO: Update the channel
    setState(() {});
  }

  void _deleteChannel() {
    //TODO: Delete the channel
    showConfirmDialog(
        context: context,
        title: 'Delete Channel',
        content: 'Are you sure to delete this channel?');
    setState(() {});
  }

  Widget _buildChannelNameField() {
    return CustomizedTextField(
      labelText: 'Channel Name',
      initialValue: widget.channel.name,
    );
  }

  Widget _buildChannelDescriptionField() {
    return CustomizedTextField(
      labelText: 'Channel Description',
      initialValue: widget.channel.description,
      maxLines: 5,
    );
  }

  Widget _buildSaveAndDeleteButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              _saveChannelInfo();
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
            onPressed: _deleteChannel,
            child: const Text('Delete Channel'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Channel'),
      ),
      body: Stack(children: [
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/svg/edit_channel.svg',
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildChannelNameField(),
              const SizedBox(height: 15.0),
              _buildChannelDescriptionField(),
              const SizedBox(height: 10.0),
              _buildSaveAndDeleteButtons(),
            ],
          ),
        ),
      ]),
    );
  }
}
