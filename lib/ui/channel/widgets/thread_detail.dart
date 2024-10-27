import 'package:flutter/material.dart';

import '../../../common/enums.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/widgets/index.dart';
import '../../screens.dart';
import './index.dart';

class ThreadDetail extends StatelessWidget {
  ThreadDetail(
    this.thread, {
    super.key,
  });

  final Thread thread;

  // TODO: User who is currently logged in
  final User user = User(
    id: '1',
    fullname: 'John Doe',
    jobTitle: 'Software Engineer',
    username: 'johndoe',
    avatarUrl: 'https://picsum.photos/300/300',
    email: 'john@gmail.com',
  );

  void _showThreadActions(BuildContext context) {
    showModalBottomSheetActions(
      context: context,
      title: 'Thread Options',
      body: ThreadActions(thread),
    );
  }

  void _showThreadDetails(BuildContext context) {
    Navigator.of(context).pushNamed(
      ThreadScreen.routeName,
      arguments: thread.id,
    );
  }

  bool _hasReaction(List<Reaction> listReaction) {
    return listReaction.any((reaction) => reaction.creatorId == user.id);
  }

  void _onReactionPressed(ReactionType type) {
    if (_hasReaction(thread.reactions[type]!)) {
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
      onTap: () => _showThreadDetails(context),
      onLongPress: () => _showThreadActions(context),
      child: ThreadCard(
        creator: thread.creator,
        createdAt: thread.createdAt,
        content: thread.content,
        mediaUrls: thread.mediaUrls,
        reactions: thread.reactions,
        comments: thread.comments,
        tasks: thread.tasks,
        onReactionPressed: _onReactionPressed,
      ),
    );
  }
}
