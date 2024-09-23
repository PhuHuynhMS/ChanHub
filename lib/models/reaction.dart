import '../common/enums.dart';
import './user.dart';

class Reaction {
  final String id;
  final String creatorId;
  final ReactionType type;
  final DateTime createdAt;
  final User creator;

  Reaction({
    required this.id,
    required this.creatorId,
    required this.type,
    required this.createdAt,
    required this.creator,
  });

  Reaction copyWith({
    String? id,
    String? creatorId,
    ReactionType? type,
    DateTime? createdAt,
    User? creator,
  }) {
    return Reaction(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }
}
