import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/channel.dart';
import '../../models/thread.dart';
import '../thread/threads_manager.dart';
import '../shared/widget/message_input.dart';
import './channel_description.dart';
import './thread_detail.dart';

class ChannelScreen extends StatelessWidget {
  static const String routeName = '/channel';

  const ChannelScreen(
    this.channel, {
    super.key,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    // TODO: Get all threads of the channel
    final List<Thread> threads = ThreadsManager().getAll();

    Widget buildThreadDetail(int index) {
      if (index < threads.length) {
        return ThreadDetail(threads[index]);
      }
      return ChannelDescription(channel);
    }

    void onEditChannelDescription() {
      print('Edit channel');
    }

    void onAddChannelMember() {
      print('Add channel member');
    }

    void onSendMessage(String message, List<File> mediaUrls) {
      print('Send message: $message');
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: ChannelTitle(channel),
          actions: [
            // Edit channel and add member buttons
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEditChannelDescription,
            ),
            IconButton(
              icon: const Icon(Icons.person_add),
              onPressed: onAddChannelMember,
            ),
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(bottom: 60.0),
          reverse: true,
          itemCount: threads.length + 1,
          itemBuilder: (context, index) => buildThreadDetail(index),
        ),
        bottomSheet: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (context) => MessageInput(
            onAddMedia: () {},
            onSend: onSendMessage,
          ),
        ),
      ),
    );
  }
}

class ChannelTitle extends StatelessWidget {
  const ChannelTitle(
    this.channel, {
    super.key,
  });

  final Channel channel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '# ${channel.name}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          '${channel.memberCount} members',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
