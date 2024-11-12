import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../common/enums.dart';
import '../../../common/constants.dart';
import '../../../models/index.dart';
import '../utils/index.dart';
import './index.dart';

class TaskPreview extends StatelessWidget {
  TaskPreview(
    this.threadTasks, {
    super.key,
    required this.onTaskStatusChanged,
  });

  final List<Task> threadTasks;
  final Future<void> Function(Task) onTaskStatusChanged;
  late final ValueNotifier<List<Task>> tasks = ValueNotifier(threadTasks);

  bool _isAssignedToMe(BuildContext context, Task task) {
    final loggedInUser = context.read<AuthManager>().loggedInUser;
    return task.assignee == null || task.assignee!.id == loggedInUser!.id;
  }

  void _onChecked(BuildContext context, bool value, Task task) {
    if (_isAssignedToMe(context, task)) {
      List<Task> newTasks = List<Task>.from(tasks.value);
      int index = tasks.value.indexWhere((element) => element.id == task.id);
      newTasks[index] = task.copyWith(isCompleted: value);
      onTaskStatusChanged(task);
      tasks.value = newTasks;
    } else {
      showInfoSnackBar(
        context: context,
        message: 'You are not assigned to this task',
      );
    }
  }

  void showTaskDetails(BuildContext context) {
    // Open dialog for task details
    showInfoDialog(
      context: context,
      title: 'Task details',
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: tasks,
          builder: (context, value, __) {
            int completedTasks =
                tasks.value.where((task) => task.isCompleted).length;
            int totalTasks = tasks.value.length;
            return ProgressBar(
              title: '$completedTasks/$totalTasks tasks completed',
              total: totalTasks,
              completed: completedTasks,
            );
          },
        ),
        for (int index = 0; index < tasks.value.length; index++)
          ValueListenableBuilder(
            valueListenable: tasks,
            builder: (context, value, __) {
              Task task = value[index];
              return _buildExpansionCheckboxTile(context, task);
            },
          ),
      ],
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
              builder: (context, value, __) {
                final completedTasks =
                    tasks.value.where((task) => task.isCompleted).length;
                final totalTasks = tasks.value.length;
                return ProgressBar(
                  title: '$completedTasks/$totalTasks tasks completed',
                  total: totalTasks,
                  completed: completedTasks,
                );
              }),

          Column(
            children: <Widget>[
              for (int index = 0; index < tasks.value.length; index++)
                ValueListenableBuilder(
                  valueListenable: tasks,
                  builder: (context, value, __) {
                    Task task = value[index];
                    return _buildTaskPreviewItem(context, task);
                  },
                )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTaskPreviewItem(BuildContext context, Task task) {
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
            '${task.assignee?.fullname ?? 'Everyone'} - ${formatDeadlineTime(task.deadline)}',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
      value: task.isCompleted,
      onChanged: (bool? value) {
        _onChecked(context, value ?? false, task);
      },
    );
  }

  Widget _buildExpansionCheckboxTile(BuildContext context, Task task) {
    TaskStatus status = getTaskStatus(task.deadline, task.completedAt);
    return ExpansionTile(
      shape: const Border(),
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10.0),
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _buildTaskStatusChip(context, status),
          const SizedBox(width: 5.0),
          Text(
            task.title,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: task.description.isNotEmpty
              ? Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodySmall,
                )
              : null,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Assignee: ${task.assignee?.fullname ?? 'Everyone'}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                'Deadline: ${formatDeadlineTime(task.deadline)}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              if (task.isCompleted) ...[
                Text(
                  'Completed by: ${task.completedBy?.fullname ?? ''}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTaskStatusChip(BuildContext context, TaskStatus status) {
    Color statusColor = getTaskStatusColor(status, context);
    String statusString = taskStatusString[status]!;
    return StatusChip(
      color: statusColor,
      title: statusString,
    );
  }
}
