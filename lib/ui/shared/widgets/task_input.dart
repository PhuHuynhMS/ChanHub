import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../utils/index.dart';
import './index.dart';

class TaskInput extends StatefulWidget {
  const TaskInput({
    super.key,
    required this.taskData,
    required this.assignees,
    this.isEdit = false,
  });

  final Task taskData;
  final List<User> assignees;
  final bool isEdit;

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  late Task editedTask = Task(
    id: widget.taskData.id,
    title: widget.taskData.title,
    description: widget.taskData.description,
    assignee: widget.taskData.assignee,
    deadline: widget.taskData.deadline,
  );
  late List<User> assignees = widget.assignees;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
              widget.isEdit ? 'Edit Task' : 'Add Task',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10.0),
            const Divider(),

            // Content
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildTitleField(),
                      _buildDescriptionField(),
                      _buildAssigneeField(),
                      _buildDeadlineField(),

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          _buildCancelButton(),
                          _buildSubmitButton(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      initialValue: editedTask.title,
      decoration: underlineInputDecoration(context, 'Title'),
      style: Theme.of(context).textTheme.bodyMedium,
      validator: Validator.compose([
        Validator.required('Title is required'),
      ]),
      onSaved: (value) => editedTask = editedTask.copyWith(title: value),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      initialValue: editedTask.description,
      minLines: 1,
      maxLines: 3,
      decoration: underlineInputDecoration(context, 'Description'),
      style: Theme.of(context).textTheme.bodyMedium,
      onSaved: (value) => editedTask = editedTask.copyWith(description: value),
    );
  }

  Widget _buildAssigneeField() {
    return UnderlineDropdownButton<User>(
      hint: 'Assignee',
      selectedValue: editedTask.assignee,
      items: assignees,
      onChanged: _onSelectAssignee,
    );
  }

  Widget _buildDeadlineField() {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      onPressed: _onShowDateTimePicker,
      child: Row(
        children: <Widget>[
          const Icon(Icons.calendar_today),
          const SizedBox(width: 10.0),
          Text(
            formatDeadlineTime(editedTask.deadline),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  void _onSelectAssignee(User? value) {
    editedTask = editedTask.copyWith(assignee: value);
    setState(() {});
  }

  void _onShowDateTimePicker() async {
    final DateTime? deadline = await showDateTimePicker(context);

    if (deadline != null) {
      editedTask = editedTask.copyWith(deadline: deadline);
      setState(() {});
    }
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: _onClose,
      child: Text(
        'Close',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return TextButton(
      onPressed: _onAddTask,
      child: Text(
        'Add',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  void _onAddTask() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    Navigator.of(context).pop(editedTask);
  }

  void _onClose() {
    Navigator.of(context).pop();
  }
}
