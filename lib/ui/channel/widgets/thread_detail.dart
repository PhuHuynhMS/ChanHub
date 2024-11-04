import 'package:flutter/material.dart';

import '../../../common/enums.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/widgets/index.dart';
import '../../screens.dart';
import './index.dart';

class ThreadDetail extends StatelessWidget {
  const ThreadDetail(
    this.thread, {
    super.key,
    required this.onChangeTaskStatus,
    required this.onReactionPressed,
  });

  final Thread thread;
  final Function(Task) onChangeTaskStatus;
  final Function(ReactionType) onReactionPressed;

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
          onReactionPressed: onReactionPressed,
          onChangeTaskStatus: onChangeTaskStatus,
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
