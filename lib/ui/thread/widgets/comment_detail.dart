import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/widgets/index.dart';
import './index.dart';

class CommentDetail extends StatelessWidget {
  const CommentDetail(this.comment, {super.key});

  final Comment comment;

  void _showcommentActions(BuildContext context) {
    showModalBottomSheetActions(
      context: context,
      title: 'Comment Options',
      body: CommentActions(comment),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isCreator =
        comment.creator!.id == context.read<AuthManager>().loggedInUser!.id;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: isCreator ? () => _showcommentActions(context) : null,
      child: ThreadCard(
        creator: comment.creator!,
        createdAt: comment.createdAt!,
        updatedAt: comment.updatedAt,
        content: comment.content,
        mediaUrls: comment.mediaUrls,
        onReactionPressed: (reaction) async {},
        onChangeTaskStatus: (task) async {},
      ),
    );
  }
}
