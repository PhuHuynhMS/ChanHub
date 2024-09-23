import './user.dart';

class Comment {
  final String id;
  final String content;
  final List<String> mediaUrls;
  final String creatorId;
  final DateTime createdAt;
  final User creator;

  Comment({
    required this.id,
    required this.content,
    required this.mediaUrls,
    required this.creatorId,
    required this.createdAt,
    required this.creator,
  });

  Comment copyWith({
    String? id,
    String? content,
    List<String>? mediaUrls,
    String? creatorId,
    DateTime? createdAt,
    User? creator,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }
}
