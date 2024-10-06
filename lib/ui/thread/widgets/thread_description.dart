import 'package:flutter/material.dart';

import '../../../common/enums.dart';
import '../../../models/index.dart';
import '../../shared/widgets/index.dart';

class ThreadDescription extends StatelessWidget {
  ThreadDescription(
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
    return Container(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
      child: ThreadCard(
        creator: thread.creator,
        createdAt: thread.createdAt,
        content: thread.content,
        mediaUrls: thread.mediaUrls,
        reactions: thread.reactions,
        tasks: thread.tasks,
        onReactionPressed: onReactionPressed,
      ),
    );
  }
}
