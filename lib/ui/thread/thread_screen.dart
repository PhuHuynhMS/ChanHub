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
        title: ThreadAppBarTitle(channelName),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: thread.comments.length + 1,
          itemBuilder: (BuildContext context, int index) =>
              buildCommentDetail(thread.comments, index),
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
