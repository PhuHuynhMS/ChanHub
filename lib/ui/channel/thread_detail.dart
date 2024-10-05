import 'package:flutter/material.dart';

import '../../common/enums.dart';
import '../../models/thread.dart';
import '../../models/user.dart';
import '../../models/reaction.dart';
import '../thread/thread_screen.dart';
import '../shared/utils/bottomsheetactions.dart';
import '../shared/widget/thread_card.dart';

class ThreadDetail extends StatelessWidget {
  ThreadDetail(
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

  void showThreadActions(BuildContext context) {
    showModalBottomSheetActions(
      context: context,
      title: 'Thread Options',
      body: ThreadActions(thread),
    );
  }

  void showThreadDetails(BuildContext context) {
    Navigator.of(context).pushNamed(
      ThreadScreen.routeName,
      arguments: thread.id,
    );
  }

  bool hasReaction(List<Reaction> listReaction) {
    return listReaction.any((reaction) => reaction.creatorId == user.id);
  }

  void onReactionPressed(ReactionType type) {
    if (hasReaction(thread.reactions[type]!)) {
      // Remove reaction
      thread.reactions[type]!
          .removeWhere((reaction) => reaction.creatorId == user.id);
    } else {
      thread.reactions[type]!.add(
        // TODO: Create a new reaction
        Reaction(
          creatorId: user.id,
          type: type,
          createdAt: DateTime.now(),
          creator: user,
          id: '5',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showThreadDetails(context),
      onLongPress: () => showThreadActions(context),
      child: ThreadCard(
        creator: thread.creator,
        createdAt: thread.createdAt,
        content: thread.content,
        mediaUrls: thread.mediaUrls,
        reactions: thread.reactions,
        comments: thread.comments,
        tasks: thread.tasks,
        onReactionPressed: onReactionPressed,
      ),
    );
  }
}

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

  void showThreadDetails(BuildContext context) {
    Navigator.of(context).pushNamed(
      ThreadScreen.routeName,
      arguments: thread,
    );
  }

  void onEditThread() {
    print('Edit thread');
  }

  void onDeleteThread() {
    print('Delete thread');
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        // Reply in thread
        ListTile(
          leading: Icon(
            Icons.reply,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          title: Text(
            'Reply in thread',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          onTap: () => showThreadDetails(context),
        ),

        // Edit message and delete message
        if (thread.creatorId == user.id) ...[
          ListTile(
            leading: Icon(
              Icons.edit,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            title: Text(
              'Edit thread',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            onTap: onEditThread,
          ),
          ListTile(
            leading: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
            title: Text(
              'Delete thread',
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
            onTap: onDeleteThread,
          ),
        ],
      ],
    );
  }
}
