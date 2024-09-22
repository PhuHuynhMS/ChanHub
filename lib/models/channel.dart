import '../common/enums.dart';
import './user.dart';

class Channel {
  final String? id;
  final String name;
  final String description;
  final ChannelPrivacy privacy;
  final String creatorId;
  final DateTime createdAt;
  User creator;
  int memberCount = 0;

  Channel({
    this.id,
    required this.name,
    required this.description,
    required this.privacy,
    required this.creatorId,
    required this.createdAt,
    required this.creator,
    this.memberCount = 0,
  });

  Channel copyWith({
    String? id,
    String? name,
    String? description,
    ChannelPrivacy? privacy,
    String? creatorId,
    DateTime? createdAt,
    int? memberCount,
    User? creator,
  }) {
    return Channel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      privacy: privacy ?? this.privacy,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      memberCount: memberCount ?? this.memberCount,
      creator: creator ?? this.creator,
    );
  }
}
