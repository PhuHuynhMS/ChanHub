import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/enums.dart';
import '../../models/index.dart';
import '../../managers/index.dart';
import '../shared/utils/index.dart';
import '../shared/widgets/index.dart';
import './widgets/index.dart';

class ChannelScreen extends StatelessWidget {
  static const String routeName = '/channel';

  const ChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final channel = context.read<ChannelsManager>().getSelectedChannel()!;
    final threadsManager =
        context.watch<ChannelsManager>().getCurrentThreadsManager();
    final threads = _getThreads(threadsManager);

    // Fetch more threads when scroll to the top
    scrollController.addListener(() {
      if (scrollController.position.pixels + 50 >=
              scrollController.position.maxScrollExtent &&
          threadsManager.hasMoreThreads &&
          !threadsManager.isFetching) {
        threadsManager.fetchMoreThreads();
      }
    });

    // Mark all threads as read
    context.read<ChannelsManager>().markAllThreadsAsRead(channel.id!);

    return Scaffold(
      appBar: AppBar(
        title: ChannelAppBarTitle(channel),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu_open),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            );
          }),
        ],
      ),
      endDrawer: const ChannelDrawer(),
      body: ListView.builder(
        shrinkWrap: true,
        controller: scrollController,
        padding: const EdgeInsets.only(bottom: 50.0),
        reverse: true,
        itemCount: threads.length + 1,
        itemBuilder: (context, index) => _buildThreadDetail(
          context,
          threadsManager,
          channel,
          threads,
          index,
          threadsManager.hasMoreThreads,
        ),
      ),
      bottomSheet: BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (context) => MessageInput(
          onAddMedia: () {},
          onSend: (message, mediaFiles, tasks) => _onSendMessage(
            threadsManager,
            message,
            mediaFiles,
            tasks,
          ),
          taskAssignees:
              channel.privacy == ChannelPrivacy.private ? channel.members : [],
        ),
      ),
    );
  }

  List<Thread> _getThreads(ThreadsManager threadsManager) {
    List<Thread> threads = [];

    // Group threads by day
    for (final thread in threadsManager.getAll()) {
      final lastThread = threads.isEmpty ? null : threads.last;

      if (lastThread != null &&
          isDifferentDay(lastThread.createdAt, thread.createdAt)) {
        threads.add(Thread(
          type: ThreadType.milestone,
          content: formatMilestoneTime(lastThread.createdAt!),
        ));
      }
      threads.add(thread);
    }
    if (threads.isNotEmpty) {
      threads.add(Thread(
        type: ThreadType.milestone,
        content: formatMilestoneTime(threads.last.createdAt!),
      ));
    }
    return threads;
  }

  void _onSendMessage(
    ThreadsManager threadsManager,
    String message,
    List<File> mediaFiles,
    List<Task> tasks,
  ) async {
    await threadsManager.createThread(message, mediaFiles, tasks);
  }

  Widget _buildThreadDetail(
    BuildContext context,
    ThreadsManager threadsManager,
    Channel channel,
    List<Thread> threads,
    int index,
    bool hasMoreThreads,
  ) {
    if (index < threads.length) {
      return ThreadDetail(threads[index]);
    }
    if (hasMoreThreads) {
      return getLoadingAnimation(context);
    }
    return ChannelDescription(channel);
  }
}
