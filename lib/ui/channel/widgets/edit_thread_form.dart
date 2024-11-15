import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/index.dart';
import '../../../managers/index.dart';
import '../../shared/widgets/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/extensions/index.dart';

class EditThreadForm extends StatefulWidget {
  const EditThreadForm(this.thread, {super.key});

  final Thread thread;

  @override
  State<EditThreadForm> createState() => _EditThreadFormState();
}

class _EditThreadFormState extends State<EditThreadForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Thread _editedThread;

  @override
  void initState() {
    super.initState();
    _editedThread = widget.thread;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Thread content field
          _buildThreadContentField(),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Only the message can be edited',
              style: Theme.of(context).textTheme.labelSmall,
              textAlign: TextAlign.end,
            ),
          ),
          const SizedBox(height: 10),

          // Media preview
          if (widget.thread.mediaUrls.isNotEmpty) ...[
            MediaPreview(
              widget.thread.mediaUrls,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 10),
          ],

          // Task preview
          if (widget.thread.tasks.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '+ ${widget.thread.tasks.length} task${widget.thread.tasks.length > 1 ? 's' : ''}',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.end,
              ),
            ),

          // Actions
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: _onCancel,
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: _onSave,
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThreadContentField() {
    return TextFormField(
      initialValue: widget.thread.content,
      decoration: underlineInputDecoration(context, 'Type a message'),
      style: Theme.of(context).textTheme.bodyMedium,
      validator: Validator.compose([
        Validator.maxLength(1024, 'Message is too long'),
      ]),
      onSaved: (value) =>
          _editedThread = _editedThread.copyWith(content: value),
    );
  }

  void _onCancel() {
    Navigator.of(context).pop();
  }

  void _onSave() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    context.executeWithErrorHandling(() async {
      await context
          .read<ChannelsManager>()
          .getCurrentThreadsManager()
          .updateThread(_editedThread);
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }
}
