import '../common/enums.dart';
import './user.dart';
import './reaction.dart';

class Comment {
  final String id;
  final String content;
  final List<String> mediaUrls;
  final Map<ReactionType, List<Reaction>> reactions;
  final String creatorId;
  final DateTime createdAt;
  final User creator;

  Comment({
    required this.id,
    required this.content,
    required this.mediaUrls,
    required this.reactions,
    required this.creatorId,
    required this.createdAt,
    required this.creator,
  });

  Comment copyWith({
    String? id,
    String? content,
    List<String>? mediaUrls,
    Map<ReactionType, List<Reaction>>? reactions,
    String? creatorId,
    DateTime? createdAt,
    User? creator,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      reactions: reactions ?? this.reactions,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }
}
