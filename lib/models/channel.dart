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
  List<User> members;

  int get memberCount => members.length;

  Channel({
    this.id,
    required this.name,
    required this.description,
    required this.privacy,
    required this.creatorId,
    required this.createdAt,
    required this.creator,
    this.members = const [],
  });

  Channel copyWith({
    String? id,
    String? name,
    String? description,
    ChannelPrivacy? privacy,
    String? creatorId,
    DateTime? createdAt,
    List<User>? members,
    User? creator,
  }) {
    return Channel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      privacy: privacy ?? this.privacy,
      creatorId: creatorId ?? this.creatorId,
      createdAt: createdAt ?? this.createdAt,
      members: members ?? this.members,
      creator: creator ?? this.creator,
    );
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      privacy: json['privacy'] == 'public'
          ? ChannelPrivacy.public
          : ChannelPrivacy.private,
      creatorId: json['creator'],
      createdAt: DateTime.parse(json['created']),
      members: ((json['expand']['channel_members_via_channel'] ?? []) as List)
          .map((channelMember) =>
              User.fromJson(channelMember['expand']['member']))
          .toList(),
      creator: User.fromJson(json['expand']['creator']),
    );
  }
}
