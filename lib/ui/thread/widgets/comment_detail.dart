import 'package:flutter/material.dart';

import '../../../common/enums.dart';
import '../../../models/index.dart';
import '../../shared/widgets/index.dart';

class CommentDetail extends StatelessWidget {
  CommentDetail(
    this.comment, {
    super.key,
  });

  final Comment comment;
// TODO: User who is currently logged in
  final User user = User(
    id: '1',
    fullname: 'John Doe',
    jobTitle: 'Software Engineer',
    username: 'johndoe',
    avatarUrl: 'https://picsum.photos/300/300',
    email: 'john@gmail.com',
  );

  bool _hasReaction(List<Reaction> listReaction) {
    return listReaction.any((reaction) => reaction.creator.id == user.id);
  }

  void _onReactionPressed(ReactionType type) {
    if (_hasReaction(comment.reactions[type]!)) {
      // Remove reaction
      comment.reactions[type]!
          .removeWhere((reaction) => reaction.creator.id == user.id);
    } else {
      comment.reactions[type]!.add(
        // TODO: Create a new reaction
        Reaction(
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
      creator: comment.creator,
      createdAt: comment.createdAt,
      content: comment.content,
      mediaUrls: comment.mediaUrls,
      // reactions: comment.reactions,
      onReactionPressed: _onReactionPressed,
      onChangeTaskStatus: (task) {},
    );
  }
}
