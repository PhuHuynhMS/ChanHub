import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../managers/index.dart';
import '../shared/widgets/index.dart';
import './widgets/index.dart';

class ThreadScreen extends StatelessWidget {
  static const String routeName = '/thread';

  const ThreadScreen(
    this.threadId, {
    super.key,
  });

  final String threadId;

  Widget buildCommentDetail(Thread thread, int index) {
    if (index < thread.comments.length) {
      return CommentDetail(thread.comments[index]);
    }
    return ThreadDescription(thread);
  }

  @override
  Widget build(BuildContext context) {
    final channelsManager = context.watch<ChannelsManager>();
    final channel = channelsManager.getSelectedChannel()!;
    final thread =
        channelsManager.getCurrentThreadsManager().getById(threadId)!;

    return Scaffold(
      appBar: AppBar(
        title: ThreadAppBarTitle(channel.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: thread.comments.length + 1,
          itemBuilder: (BuildContext context, int index) =>
              buildCommentDetail(thread, index),
        ),
      ),
      bottomSheet: BottomSheet(
          onClosing: () {},
          enableDrag: false,
          builder: (context) {
            return MessageInput(
              onSend: (content, mediaFiles, _) => _onSendMessage(
                channelsManager.getCurrentThreadsManager(),
                content,
                mediaFiles,
              ),
              canAddTask: false,
            );
          }),
    );
  }

  void _onSendMessage(
    ThreadsManager threadsManager,
    String message,
    List<File> mediaFiles,
  ) async {
    final thread = threadsManager.getById(threadId)!;
    await threadsManager.addCommentToThread(thread, message, mediaFiles);
  }
}
