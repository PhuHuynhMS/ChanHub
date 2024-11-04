import '../common/constants.dart';
import '../common/enums.dart';
import './user.dart';

class Reaction {
  final String id;
  final ReactionType type;
  final DateTime createdAt;
  final User creator;

  Reaction({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.creator,
  });

  Reaction copyWith({
    String? id,
    ReactionType? type,
    DateTime? createdAt,
    User? creator,
  }) {
    return Reaction(
      id: id ?? this.id,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
    );
  }

  factory Reaction.fromJson(Map<String, dynamic> json) {
    return Reaction(
      id: json['id'],
      type: reactionType[json['type']] ?? ReactionType.like,
      createdAt: DateTime.parse(json['created']),
      creator: User.fromJson(json['expand']['creator']),
    );
  }
}
