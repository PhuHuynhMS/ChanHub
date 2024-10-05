import 'package:flutter/material.dart';

import '../../../common/enums.dart';
import '../../../common/constants.dart';
import '../../../models/comment.dart';
import '../../../models/reaction.dart';
import '../../../models/task.dart';
import '../../../models/user.dart';
import '../utils/threadcomment.dart';
import '../utils/task.dart';
import '../utils/datetime.dart';
import './media_preview.dart';
import './thread_reaction.dart';
import './progress_bar.dart';
import './user_avatar.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard({
    super.key,
    required this.creator,
    required this.createdAt,
    this.content,
    this.mediaUrls,
    this.tasks,
    this.reactions,
    this.comments,
    required this.onReactionPressed,
  });

  final User creator;
  final DateTime createdAt;
  final String? content;
  final List<String>? mediaUrls;
  final List<Task>? tasks;
  final Map<ReactionType, List<Reaction>>? reactions;
  final List<Comment>? comments;
  final void Function(ReactionType) onReactionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Avatar
          UserAvatar(creator),
          const SizedBox(width: 10.0),

          // Content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header
                ThreadTitle(creator, createdAt),

                // Body (Content, Media, Reaction)
                if (content != null) ThreadContent(content!),

                if (mediaUrls != null && mediaUrls!.isNotEmpty) ...[
                  const SizedBox(height: 5.0),
                  MediaPreview(mediaUrls!),
                ],

                if (tasks != null && tasks!.isNotEmpty) ...[
                  const SizedBox(height: 5.0),
                  ThreadTask(tasks!),
                ],

                if (reactions != null && reactions!.isNotEmpty) ...[
                  const SizedBox(height: 5.0),
                  ThreadReaction(
                    reactions!,
                    onReactionPressed: onReactionPressed,
                  ),
                ],

                // Footer
                if (comments != null && comments!.isNotEmpty) ...[
                  const SizedBox(height: 5.0),
                  ThreadComment(comments!.length),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThreadTitle extends StatelessWidget {
  const ThreadTitle(
    this.user,
    this.createdAt, {
    super.key,
  });

  final User user;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Username
          Text(
            user.fullName,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),

          // Timestamp
          Text(
            formatDateTime(createdAt),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
    );
  }
}

class ThreadContent extends StatelessWidget {
  const ThreadContent(
    this.content, {
    super.key,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
    );
  }
}

class ThreadComment extends StatelessWidget {
  const ThreadComment(
    this.totalReplies, {
    super.key,
  });

  final int totalReplies;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTotalReplies(totalReplies),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
    );
  }
}

class ThreadTask extends StatefulWidget {
  const ThreadTask(this.tasks, {super.key});

  final List<Task> tasks;

  @override
  State<ThreadTask> createState() => _ThreadTaskState();
}

class _ThreadTaskState extends State<ThreadTask> {
  late ValueNotifier<List<Task>> tasks;

  @override
  void initState() {
    tasks = ValueNotifier(widget.tasks);
    super.initState();
  }

  void onChecked(bool value, Task task) {
    int index = tasks.value.indexWhere((element) => element.id == task.id);
    tasks.value[index] = task.copyWith(
        isCompleted: value, completedAt: value ? DateTime.now() : null);
    tasks.notifyListeners();
  }

  Widget buildExpansionCheckboxTile(BuildContext context, Task task) {
    TaskStatus status = getTaskStatus(task.deadline, task.completedAt);
    return ExpansionTile(
      shape: const Border(),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: task.isCompleted ?? false,
            onChanged: (bool? value) => onChecked(value!, task),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                task.title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                '(${taskStatusString[status]!})',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: getTaskStatusColor(status, context),
                    ),
              ),
            ],
          ),
        ],
      ),
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            task.description,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          subtitle: Text(
            'Assignee: ${task.assignee.fullName} \nDeadline: ${formatDeadlineTime(task.deadline)}',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.6),
                ),
          ),
        ),
      ],
    );
  }

  void showTaskDetails(BuildContext context) {
    // Open dialog for task details
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 150.0),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
              bottom: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title
                Text(
                  'Tasks',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Divider(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                ),
                const SizedBox(height: 10.0),
                // Progress bar
                ValueListenableBuilder(
                  valueListenable: tasks,
                  builder: (context, value, __) {
                    int completedTasks = tasks.value
                        .where((task) => task.isCompleted ?? false)
                        .length;
                    int totalTasks = tasks.value.length;
                    return ProgressBar(
                      title: '$completedTasks/$totalTasks tasks completed',
                      total: totalTasks,
                      completed: completedTasks,
                    );
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.value.length,
                    itemBuilder: (context, index) {
                      return ValueListenableBuilder(
                        valueListenable: tasks,
                        builder: (context, value, __) {
                          final Task task = value[index];
                          return buildExpansionCheckboxTile(context, task);
                        },
                      );
                    },
                  ),
                ),

                // Close button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Close',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => showTaskDetails(context),

      // Task list
      child: Column(
        children: <Widget>[
          // Progress bar
          ValueListenableBuilder(
            valueListenable: tasks,
            builder: (context, value, __) => Column(
              children: [
                Text(
                  '${tasks.value.where((task) => task.isCompleted ?? false).length}/${tasks.value.length} tasks completed',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 5.0),
                LinearProgressIndicator(
                  value: tasks.value
                          .where((task) => task.isCompleted ?? false)
                          .length /
                      tasks.value.length,
                  backgroundColor: Theme.of(context).colorScheme.tertiary,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: <Widget>[
              for (int index = 0; index < tasks.value.length; index++)
                ValueListenableBuilder(
                  valueListenable: tasks,
                  builder: (context, value, __) {
                    Task task = value[index];
                    return CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Task title
                          Text(
                            task.title,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),

                          // Short description (assignee, deadline)
                          Text(
                            textAlign: TextAlign.end,
                            '${task.assignee.fullName} - ${formatDateTime(task.deadline)}',
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withOpacity(0.6),
                                    ),
                          ),
                        ],
                      ),
                      value: task.isCompleted ?? false,
                      onChanged: (bool? value) {
                        onChecked(value!, task);
                      },
                    );
                  },
                )
            ],
          ),
        ],
      ),
    );
  }
}
