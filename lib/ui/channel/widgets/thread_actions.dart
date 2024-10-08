import 'package:flutter/material.dart';

import '../../../models/index.dart';
import '../../screens.dart';

class ThreadActions extends StatelessWidget {
  ThreadActions(
    this.thread, {
    super.key,
  });

  final Thread thread;

  // TODO: User who is currently logged in
  final User user = User(
    id: '1',
    fullName: 'John Doe',
    userName: 'johndoe',
    avatarUrl: 'https://picsum.photos/300/300',
    email: 'john@gmail.com',
  );

  void _showThreadDetails(BuildContext context) {
    Navigator.of(context).pushNamed(
      ThreadScreen.routeName,
      arguments: thread,
    );
  }

  void _onEditThread() {
    print('Edit thread');
  }

  void _onDeleteThread() {
    print('Delete thread');
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        // Reply in thread
        ListTile(
          leading: const Icon(Icons.reply),
          title: const Text('Reply in thread'),
          onTap: () => _showThreadDetails(context),
        ),

        // Edit message and delete message
        if (thread.creatorId == user.id) ...[
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit thread'),
            onTap: _onEditThread,
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete thread'),
            textColor: Theme.of(context).colorScheme.error,
            iconColor: Theme.of(context).colorScheme.error,
            onTap: _onDeleteThread,
          ),
        ],
      ],
    );
  }
}
