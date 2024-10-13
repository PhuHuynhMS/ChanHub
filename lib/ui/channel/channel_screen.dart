import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../shared/widgets/index.dart';
import '../screens.dart';
import './widgets/index.dart';

class ChannelScreen extends StatelessWidget {
  static const String routeName = '/channel';

  const ChannelScreen(
    this.channel, {
    super.key,
  });

  final Channel channel;

  void _onSendMessage(String message, List<File> mediaUrls) {
    print('Send message: $message');
  }

  Widget _buildThreadDetail(List<Thread> threads, int index) {
    if (index < threads.length) {
      return ThreadDetail(threads[index]);
    }
    return ChannelDescription(channel);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Get all threads of the channel
    final List<Thread> threads = ThreadsManager().getAll();

    return Scaffold(
      appBar: AppBar(
        title: ChannelAppBarTitle(channel),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu_open),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
              },
            );
          }),
        ],
      ),
      endDrawer: const ChannelDrawer(),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 50.0),
        reverse: true,
        itemCount: threads.length + 1,
        itemBuilder: (context, index) => _buildThreadDetail(threads, index),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (context) => MessageInput(
          onAddMedia: () {},
          onSend: _onSendMessage,
        ),
      ),
    );
  }
}
