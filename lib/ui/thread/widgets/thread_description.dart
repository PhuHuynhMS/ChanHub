import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/index.dart';
import '../../../managers/index.dart';
import '../../shared/widgets/index.dart';

class ThreadDescription extends StatelessWidget {
  const ThreadDescription(
    this.thread, {
    super.key,
  });

  final Thread thread;

  Future<void> _onChangeTaskStatus(
      ThreadsManager threadsManager, Task task) async {
    await threadsManager.changeTaskStatus(task);
  }

  Future<void> _onReactionPressed(
      ThreadsManager threadsManager, Reaction reaction) async {
    await threadsManager.reactToThread(thread, reaction);
  }

  @override
  Widget build(BuildContext context) {
    final threadsManager =
        context.read<ChannelsManager>().getCurrentThreadsManager();
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      child: ThreadCard(
        creator: thread.creator!,
        createdAt: thread.createdAt!,
        updatedAt: thread.updatedAt,
        content: thread.content,
        mediaUrls: thread.mediaUrls,
        reactions: thread.reactions,
        tasks: thread.tasks,
        onReactionPressed: (reaction) async =>
            await _onReactionPressed(threadsManager, reaction),
        onChangeTaskStatus: (task) async =>
            await _onChangeTaskStatus(threadsManager, task),
      ),
    );
  }
}
