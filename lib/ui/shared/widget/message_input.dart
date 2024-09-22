import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/utils/photogallery.dart';

// TODO: It should be refactored to use the `MediaPreview` widget
class MessageInput extends StatefulWidget {
  const MessageInput({
    super.key,
    this.onAddMedia,
    required this.onSend,
  });

  final void Function()? onAddMedia;
  final void Function(String, List<File>) onSend;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  late List<File> mediaFiles = [];

  bool get isMessageEmpty =>
      _messageController.text.trim().isEmpty && mediaFiles.isEmpty;

  void onSend() {
    setState(() {
      widget.onSend(_messageController.text, mediaFiles);
      _messageController.clear();
      mediaFiles.clear();
    });
  }

  void onAddMedia() async {
    final List<XFile> pickedFiles = await _imagePicker.pickMultiImage();
    setState(() {
      mediaFiles.addAll(pickedFiles.map((file) => File(file.path)));
    });
  }

  void onRemoveMedia(int index) {
    setState(() {
      mediaFiles.removeAt(index);
    });
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
          // Message input field
          Row(
            children: <Widget>[
              // Add media button
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: onAddMedia,
              ),

              // Message input field
              Expanded(
                child: TextField(
                  maxLines: 5,
                  minLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.5),
                        ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(10.0),
                  ),
                  controller: _messageController,
                ),
              ),

              // Send message button
              ValueListenableBuilder(
                valueListenable: _messageController,
                builder: (context, value, _) => IconButton(
                  icon: Icon(
                    Icons.send,
                    color: isMessageEmpty
                        ? Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.5)
                        : Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: isMessageEmpty ? null : onSend,
                ),
              ),
            ],
          ),

          // Media preview
          if (mediaFiles.isNotEmpty)
            SizedBox(
              height: 100.0,
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mediaFiles.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: <Widget>[
                      // Media preview
                      GestureDetector(
                        onTap: () => showPhotoViewGallery(
                          context,
                          mediaFiles.map((file) => FileImage(file)).toList(),
                          index,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(
                              mediaFiles[index],
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
                          onTap: () => onRemoveMedia(index),
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
                },
              ),
            ),
        ],
      ),
    );
  }
}
