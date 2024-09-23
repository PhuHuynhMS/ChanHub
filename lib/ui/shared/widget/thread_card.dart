import 'package:flutter/material.dart';

import '../../../common/enums.dart';
import '../../../models/comment.dart';
import '../../../models/reaction.dart';
import '../../../models/user.dart';
import '../utils/threadcomment.dart';
import '../utils/datetime.dart';
import './media_preview.dart';
import './thread_reaction.dart';
import './user_avatar.dart';

class ThreadCard extends StatelessWidget {
  const ThreadCard(
    this.createdAt,
    this.content,
    this.mediaUrls,
    this.reactions,
    this.comments,
    this.user, {
    super.key,
    required this.onReactionPressed,
  });

  final User user;
  final DateTime createdAt;
  final String? content;
  final List<String>? mediaUrls;
  final Map<ReactionType, List<Reaction>>? reactions;
  final List<Comment>? comments;
  final void Function(ReactionType) onReactionPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Avatar
          UserAvatar(user),
          const SizedBox(width: 10.0),

          // Content
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header
                ThreadTitle(user, createdAt),

                // Body (Content, Media, Reaction)
                if (content != null) ThreadContent(content!),

                if (mediaUrls != null && mediaUrls!.isNotEmpty) ...[
                  const SizedBox(height: 5.0),
                  MediaPreview(mediaUrls!),
                ],

                if (reactions != null && reactions!.isNotEmpty) ...[
                  const SizedBox(height: 5.0),
                  ThreadReaction(
                    reactions!,
                    onReactionPressed: onReactionPressed,
                  ),
                ],

                // Footer
                if (comments != null && comments!.isNotEmpty) ...[
                  const SizedBox(height: 5.0),
                  ThreadComment(comments!.length),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ThreadTitle extends StatelessWidget {
  const ThreadTitle(
    this.user,
    this.createdAt, {
    super.key,
  });

  final User user;
  final DateTime createdAt;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Username
          Text(
            user.fullName,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),

          // Timestamp
          Text(
            formatDateTime(createdAt),
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
    );
  }
}

class ThreadContent extends StatelessWidget {
  const ThreadContent(
    this.content, {
    super.key,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
    );
  }
}

class ThreadComment extends StatelessWidget {
  const ThreadComment(
    this.totalReplies, {
    super.key,
  });

  final int totalReplies;

  @override
  Widget build(BuildContext context) {
    return Text(
      formatTotalReplies(totalReplies),
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.secondary,
          ),
    );
  }
}
