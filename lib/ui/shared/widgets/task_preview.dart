import 'package:flutter/material.dart';

import '../../../common/enums.dart';
import '../../../common/constants.dart';
import '../../../models/index.dart';
import '../utils/index.dart';
import './index.dart';

class TaskPreview extends StatelessWidget {
  TaskPreview(this.threadTasks, {super.key});

  final List<Task> threadTasks;
  late final ValueNotifier<List<Task>> tasks = ValueNotifier(threadTasks);

  void _onChecked(bool value, Task task) {
    List<Task> newTasks = List<Task>.from(tasks.value);
    int index = tasks.value.indexWhere((element) => element.id == task.id);
    newTasks[index] = task.copyWith(
        isCompleted: value, completedAt: value ? DateTime.now() : null);
    tasks.value = newTasks;
  }

  Widget _buildExpansionCheckboxTile(BuildContext context, Task task) {
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
            onChanged: (bool? value) => _onChecked(value!, task),
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
                  color: getTaskStatusColor(status, context).withOpacity(0.8),
                ),
          ),
        ),
      ],
    );
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
                tasks.value.where((task) => task.isCompleted ?? false).length;
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
                            '${task.assignee.fullName} - ${formatDeadlineTime(task.deadline)}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      value: task.isCompleted ?? false,
                      onChanged: (bool? value) {
                        _onChecked(value!, task);
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
