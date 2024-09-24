import 'package:flutter/material.dart';

import '../../common/enums.dart';
import '../../models/user.dart';
import '../../models/reaction.dart';
import '../../models/comment.dart';
import '../shared/widget/thread_card.dart';

class CommentDetail extends StatelessWidget {
  CommentDetail(
    this.comment, {
    super.key,
  });

  final Comment comment;
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
    if (hasReaction(comment.reactions[type]!)) {
      // Remove reaction
      comment.reactions[type]!
          .removeWhere((reaction) => reaction.creatorId == user.id);
    } else {
      comment.reactions[type]!.add(
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
    return ThreadCard(
      comment.creator,
      comment.createdAt,
      comment.content,
      comment.mediaUrls,
      comment.reactions,
      null,
      onReactionPressed: onReactionPressed,
    );
  }
}