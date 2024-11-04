import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/enums.dart';
import '../../../models/index.dart';
import '../../../managers/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/widgets/index.dart';
import '../../screens.dart';
import './index.dart';

class ThreadDetail extends StatelessWidget {
  const ThreadDetail(this.thread, {super.key});

  final Thread thread;

  void _onChangeTaskStatus(ThreadsManager threadsManager, Task task) async {
    await threadsManager.changeTaskStatus(task);
  }

  void _onReactionPressed(
      ThreadsManager threadsManager, Reaction reaction) async {
    await threadsManager.reactToThread(thread, reaction);
  }

  void _showThreadActions(BuildContext context) {
    showModalBottomSheetActions(
      context: context,
      title: 'Thread Options',
      body: ThreadActions(thread),
    );
  }

  void _showThreadDetails(BuildContext context) {
    Navigator.of(context).pushNamed(
      ThreadScreen.routeName,
      arguments: thread.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final threadsManager =
        context.read<ChannelsManager>().getCurrentThreadsManager();
    if (thread.type == ThreadType.message) {
      return GestureDetector(
        onTap: () => _showThreadDetails(context),
        onLongPress: () => _showThreadActions(context),
        child: ThreadCard(
          creator: thread.creator!,
          createdAt: thread.createdAt!,
          content: thread.content,
          mediaUrls: thread.mediaUrls,
          reactions: thread.reactions,
          comments: thread.comments,
          tasks: thread.tasks,
          onReactionPressed: (reaction) =>
              _onReactionPressed(threadsManager, reaction),
          onChangeTaskStatus: (task) =>
              _onChangeTaskStatus(threadsManager, task),
        ),
      );
    }
    if (thread.type == ThreadType.event) {
      return EventCard(
        creator: thread.creator!,
        createdAt: thread.createdAt!,
        content: thread.content,
      );
    }
    return MilestoneCard(
      title: thread.content!,
    );
  }
}
