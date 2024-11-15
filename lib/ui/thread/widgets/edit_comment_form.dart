import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/index.dart';
import '../../../managers/index.dart';
import '../../shared/widgets/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/extensions/index.dart';

class EditCommentForm extends StatefulWidget {
  const EditCommentForm(this.comment, {super.key});

  final Comment comment;

  @override
  State<EditCommentForm> createState() => _EditCommentFormState();
}

class _EditCommentFormState extends State<EditCommentForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Comment _editedComment;

  @override
  void initState() {
    super.initState();
    _editedComment = widget.comment;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          // Comment content field
          _buildCommentContentField(),
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
          if (widget.comment.mediaUrls.isNotEmpty)
            MediaPreview(
              widget.comment.mediaUrls,
              height: 100,
              width: 100,
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

  Widget _buildCommentContentField() {
    return TextFormField(
      initialValue: widget.comment.content,
      decoration: underlineInputDecoration(context, 'Type a message'),
      style: Theme.of(context).textTheme.bodyMedium,
      validator: Validator.compose([
        Validator.maxLength(1024, 'Message is too long'),
      ]),
      onSaved: (value) =>
          _editedComment = _editedComment.copyWith(content: value),
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
          .updateComment(_editedComment);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }, isShowLoading: true);
  }
}
