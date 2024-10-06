import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../utils/datetime.dart';
import '../utils/input_decoration.dart';
import './underline_dropdown_button.dart';

class TaskInput extends StatefulWidget {
  const TaskInput({
    super.key,
    required this.taskData,
  });

  final Map<String, dynamic> taskData;

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  late Map<String, dynamic> taskData = {
    'title': widget.taskData['title'] ?? '',
    'description': widget.taskData['description'] ?? '',
    'deadline': widget.taskData['deadline'],
    'assignee': widget.taskData['assignee'],
  };

  // TODO: Get all user from channel and display in dropdown
  final List<User> assignees = <User>[
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      avatarUrl: 'https://picsum.photos/300/300',
      email: 'john@gmail.com',
    ),
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      avatarUrl: 'https://picsum.photos/300/300',
      email: 'john@gmail.com',
    ),
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      avatarUrl: 'https://picsum.photos/300/300',
      email: 'john@gmail.com',
    ),
  ];

  void onSelectAssignee(User? value) {
    taskData['assignee'] = value;
    setState(() {});
  }

  void onShowDateTimePicker() async {
    final DateTime? deadline = await showDateTimePicker(context);

    if (deadline != null) {
      taskData['deadline'] = deadline;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 10.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Title
            Text(
              'Add task',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 10.0),
            const Divider(),

            // Content
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // Title
                    TextField(
                      decoration: underlineInputDecoration(context, 'Title'),
                      style: Theme.of(context).textTheme.bodyMedium,
                      onChanged: (value) => taskData['title'] = value,
                    ),

                    // Description
                    TextField(
                      minLines: 1,
                      maxLines: 3,
                      decoration:
                          underlineInputDecoration(context, 'Description'),
                      style: Theme.of(context).textTheme.bodyMedium,
                      onChanged: (value) => taskData['description'] = value,
                    ),

                    // Assignee
                    UnderlineDropdownButton<User>(
                      hint: 'Assignee',
                      selectedValue: taskData['assignee'],
                      items: assignees,
                      onChanged: onSelectAssignee,
                    ),

                    // Deadline
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: onShowDateTimePicker,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.calendar_today,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            formatDeadlineTime(taskData['deadline']),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),

                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            'Close',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(taskData),
                          child: Text(
                            'Add',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
