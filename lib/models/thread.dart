import '../common/enums.dart';
import './comment.dart';
import './reaction.dart';
import './user.dart';

class Thread {
  final String? id;
  final String? content;
  final List<String> mediaUrls;
  final String creatorId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final Map<ReactionType, List<Reaction>> reactions;
  final List<Comment> comments;
  User creator;

  Thread({
    this.id,
    this.content,
    required this.mediaUrls,
    required this.creatorId,
    required this.createdAt,
    required this.creator,
    this.updatedAt,
    this.reactions = const <ReactionType, List<Reaction>>{},
    this.comments = const <Comment>[],
  });

  Thread copyWith({
    String? id,
    String? content,
    List<String>? mediaUrls,
    String? creatorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<ReactionType, List<Reaction>>? reactions,
    List<Comment>? comments,
    User? creator,
  }) {
    return Thread(
      id: id ?? this.id,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reactions: reactions ?? this.reactions,
      comments: comments ?? this.comments,
      creator: creator ?? this.creator,
    );
  }
}
