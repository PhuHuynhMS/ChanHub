import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/extensions/index.dart';
import '../../shared/utils/index.dart';
import './index.dart';

class CommentActions extends StatelessWidget {
  const CommentActions(
    this.comment, {
    super.key,
  });

  final Comment comment;

  void _onEditcomment(BuildContext context) {
    Navigator.of(context).pop();
    showActionDialog(
      context: context,
      title: 'Edit comment',
      content: EditCommentForm(comment),
    );
  }

  void _onDeletecomment(BuildContext context) async {
    ThreadsManager threadsManager =
        context.read<ChannelsManager>().getCurrentThreadsManager();
    context.executeWithErrorHandling(() async {
      await threadsManager.deleteComment(comment);
    }, isShowLoading: false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUser = context.read<AuthManager>().loggedInUser;

    return Wrap(
      children: <Widget>[
        // Edit message and delete message
        if (comment.creator!.id == loggedInUser!.id) ...[
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit comment'),
            onTap: () => _onEditcomment(context),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete comment'),
            textColor: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.error,
            onTap: () => _onDeletecomment(context),
          ),
        ],
      ],
    );
  }
}
