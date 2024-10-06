import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/index.dart';
import './index.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({
    super.key,
    required this.onSend,
    this.canAddMedia = true,
    this.onAddMedia,
    this.canAddTask = true,
  });

  final bool canAddMedia;
  final void Function()? onAddMedia;
  final bool canAddTask;
  final void Function(String, List<File>) onSend; // TODO: Add task

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  late List<File> mediaFiles = [];
  late List<Map<String, dynamic>> tasks = [];
  bool showMoreActions = false;

  bool get isMessageEmpty =>
      _messageController.text.trim().isEmpty &&
      mediaFiles.isEmpty &&
      tasks.isEmpty;

  // Messages
  void onMessageChanged(String value) {
    setState(() {});
  }

  void onSend() {
    widget.onSend(_messageController.text, mediaFiles);
    _messageController.clear();
    mediaFiles.clear();
    tasks.clear();
    showMoreActions = false;
    setState(() {});
  }

  // Media
  void onAddMedia() async {
    final List<XFile> pickedFiles = await _imagePicker.pickMultiImage();
    widget.onAddMedia?.call();
    mediaFiles.addAll(pickedFiles.map((file) => File(file.path)));
    showMoreActions = !showMoreActions;
    setState(() {});
  }

  void onShowImagePreview(int index) {
    showPhotoViewGallery(
      context,
      mediaFiles.map((file) => FileImage(file)).toList(),
      index,
    );
  }

  void onRemoveMedia(int index) {
    mediaFiles.removeAt(index);
    setState(() {});
  }

  // Tasks
  void onAddTask(BuildContext context) async {
    Map<String, dynamic>? data = await showDialog(
      context: context,
      builder: (context) {
        return const TaskInput(taskData: {});
      },
    );
    if (data != null) {
      tasks.add(data);
      setState(() {});
    }
  }

  void onEditTask(BuildContext context, int index) async {
    Map<String, dynamic>? data = await showDialog(
      context: context,
      builder: (context) {
        return TaskInput(taskData: tasks[index]);
      },
    );
    if (data != null) {
      tasks[index] = data;
    }
  }

  void onRemoveTask(int index) {
    tasks.removeAt(index);
    setState(() {});
  }

  // Others
  void onShowMoreActions() {
    showMoreActions = !showMoreActions;
    setState(() {});
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
            width: 1.0,
          ),
        ),
      ),
      child: Wrap(
        children: <Widget>[
          // Message input
          Row(
            children: <Widget>[
              // More actions button
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: onShowMoreActions,
              ),

              // Message input field
              Expanded(
                child: TextField(
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                  controller: _messageController,
                  onChanged: onMessageChanged,
                ),
              ),

              // Send message button
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: isMessageEmpty
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.3)
                      : Theme.of(context).colorScheme.primary,
                ),
                onPressed: isMessageEmpty ? null : onSend,
              ),
            ],
          ),

          // Media
          if (mediaFiles.isNotEmpty) ...[
            const Divider(),
            ImagePreview(
              mediaFiles: mediaFiles,
              onRemoveMedia: onRemoveMedia,
              onShowImagePreview: onShowImagePreview,
            ),
          ],

          // Tasks
          if (tasks.isNotEmpty) ...[
            const Divider(),
            TaskPreview(
              tasks: tasks,
              onRemoveTask: onRemoveTask,
            ),
          ],

          //  More actions
          if (showMoreActions) ...[
            const Divider(),
            MoreActionButtons(
              canAddMedia: widget.canAddMedia,
              onAddMedia: onAddMedia,
              canAddTask: widget.canAddTask,
              onAddTask: onAddTask,
            ),
          ],
        ],
      ),
    );
  }

  void onTaskInput() {}
}

class MoreActionButtons extends StatelessWidget {
  const MoreActionButtons({
    super.key,
    this.canAddMedia = true,
    this.onAddMedia,
    this.canAddTask = true,
    this.onAddTask,
  });

  final bool canAddMedia;
  final void Function()? onAddMedia;
  final bool canAddTask;
  final void Function(BuildContext)? onAddTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Add media button
          if (canAddMedia)
            ActionButton(
              icon: Icons.add_a_photo,
              text: 'Add media',
              onPressed: onAddMedia!,
            ),

          // Add task button
          if (canAddTask)
            ActionButton(
              icon: Icons.add_task,
              text: 'Add task',
              onPressed: () => onAddTask!(context),
            ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final IconData icon;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Column(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.mediaFiles,
    required this.onRemoveMedia,
    required this.onShowImagePreview,
  });

  final List<File> mediaFiles;
  final void Function(int) onRemoveMedia;
  final void Function(int) onShowImagePreview;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.0,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mediaFiles.length,
        itemBuilder: (context, index) {
          return ImagePreviewItem(
            mediaFile: mediaFiles[index],
            onRemoveMedia: () => onRemoveMedia(index),
            onShowGalleryPreview: () => onShowImagePreview(index),
          );
        },
      ),
    );
  }
}

class ImagePreviewItem extends StatelessWidget {
  const ImagePreviewItem({
    super.key,
    required this.mediaFile,
    required this.onRemoveMedia,
    required this.onShowGalleryPreview,
  });

  final File mediaFile;
  final void Function() onRemoveMedia;
  final void Function() onShowGalleryPreview;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Media preview
        GestureDetector(
          onTap: onShowGalleryPreview,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(
                mediaFile,
                width: 100.0,
                height: 100.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),

        // Remove media button
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: onRemoveMedia,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Theme.of(context).colorScheme.error,
                size: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class TaskPreview extends StatelessWidget {
  const TaskPreview({
    super.key,
    required this.tasks,
    required this.onRemoveTask,
  });

  final List<Map<String, dynamic>> tasks;
  final void Function(int) onRemoveTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 150.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final Map<String, dynamic> task = tasks[index];
            return TaskPreviewItem(
              task: task,
              onRemoveTask: () => onRemoveTask(index),
            );
          },
        ),
      ),
    );
  }
}

class TaskPreviewItem extends StatelessWidget {
  const TaskPreviewItem({
    super.key,
    required this.task,
    required this.onRemoveTask,
  });

  final Map<String, dynamic> task;
  final void Function() onRemoveTask;

  @override
  Widget build(BuildContext context) {
    final Key key = Key(task['id'] ?? ('${task['title']}-${task['assignee']}'));
    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        return await showConfirmDialog(
          context: context,
          title: 'Delete task',
          content: 'Are you sure to delete this task?',
          confirmText: 'Delete',
          cancelText: 'Cancel',
        );
      },
      onDismissed: (direction) => onRemoveTask(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                task['title'],
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),

            // Assignee
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                task['assignee'].avatarUrl,
                width: 25.0,
                height: 25.0,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
