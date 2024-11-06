import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/extensions/index.dart';
import '../../shared/utils/index.dart';
import '../../screens.dart';
import './index.dart';

class ThreadActions extends StatelessWidget {
  const ThreadActions(
    this.thread, {
    super.key,
  });

  final Thread thread;

  void _showThreadDetails(BuildContext context) {
    Navigator.of(context).pushNamed(
      ThreadScreen.routeName,
      arguments: thread,
    );
  }

  void _onEditThread(BuildContext context) {
    Navigator.of(context).pop();
    showActionDialog(
      context: context,
      title: 'Edit thread',
      content: EditThreadForm(thread),
    );
  }

  void _onDeleteThread(BuildContext context) async {
    ThreadsManager threadsManager =
        context.read<ChannelsManager>().getCurrentThreadsManager();
    context.executeWithErrorHandling(() async {
      await threadsManager.deleteThread(thread);
    }, isShowLoading: false);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUser = context.read<AuthManager>().loggedInUser;

    return Wrap(
      children: <Widget>[
        // Reply in thread
        ListTile(
          leading: const Icon(Icons.reply),
          title: const Text('Reply in thread'),
          onTap: () => _showThreadDetails(context),
        ),

        // Edit message and delete message
        if (thread.creator!.id == loggedInUser!.id) ...[
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit thread'),
            onTap: () => _onEditThread(context),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete thread'),
            textColor: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.error,
            onTap: () => _onDeleteThread(context),
          ),
        ],
      ],
    );
  }
}
