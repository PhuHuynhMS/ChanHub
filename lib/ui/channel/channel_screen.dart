import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../shared/widgets/index.dart';
import '../shared/utils/index.dart';
import '../screens.dart';
import './widgets/index.dart';

class ChannelScreen extends StatelessWidget {
  static const String routeName = '/channel';

  const ChannelScreen(
    this.channel, {
    super.key,
  });

  final Channel channel;

  void onSendMessage(String message, List<File> mediaUrls) {
    print('Send message: $message');
  }

  Widget buildThreadDetail(List<Thread> threads, int index) {
    if (index < threads.length) {
      return ThreadDetail(threads[index]);
    }
    return ChannelDescription(channel);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Get all threads of the channel
    final List<Thread> threads = ThreadsManager().getAll();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: ChannelTitle(channel),
          actions: [
            // More actions
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
          itemBuilder: (context, index) => buildThreadDetail(threads, index),
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
        Row(
          children: [
            Icon(
              getChannelIcon(channel.privacy),
              size: Theme.of(context).textTheme.titleLarge!.fontSize,
            ),
            Text(
              ' ${channel.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        Text(
          '${channel.memberCount} members',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
