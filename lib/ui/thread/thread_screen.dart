import 'dart:io';

import 'package:flutter/material.dart';

import '../../models/index.dart';
import '../shared/widgets/index.dart';
import './widgets/index.dart';

class ThreadScreen extends StatelessWidget {
  static const String routeName = '/thread';

  const ThreadScreen(
    this.thread, {
    super.key,
    required this.channelName,
  });

  final Thread thread;
  final String channelName;

  Widget buildCommentDetail(List<Comment> comments, int index) {
    if (index < comments.length) {
      return CommentDetail(comments[index]);
    }
    return ThreadDescription(thread);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: ThreadTitle(channelName),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ListView.builder(
          itemCount: thread.comments.length + 1,
          itemBuilder: (BuildContext context, int index) =>
              buildCommentDetail(thread.comments, index),
          reverse: true,
          shrinkWrap: true,
        ),
      ),
      bottomSheet: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (context) {
            return MessageInput(
              onAddMedia: () {},
              onSend: (String message, List<File> mediaUrls) {
                print('Send message: $message');
              },
            );
          }),
    );
  }
}

class ThreadTitle extends StatelessWidget {
  const ThreadTitle(
    this.channelName, {
    super.key,
  });

  final String channelName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '# Thread',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Message in $channelName',
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
