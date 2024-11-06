import '../common/constants.dart';
import '../common/enums.dart';
import './user.dart';

class Channel {
  final String? id;
  final String name;
  final String description;
  final ChannelPrivacy privacy;
  final DateTime createdAt;
  User creator;
  List<User> members;

  final String? channelMemberId;
  final DateTime? lastReadAt;

  int get memberCount => members.length;

  Channel({
    this.id,
    required this.name,
    required this.description,
    required this.privacy,
    required this.createdAt,
    required this.creator,
    this.members = const [],
    this.channelMemberId,
    this.lastReadAt,
  });

  Channel copyWith({
    String? id,
    String? name,
    String? description,
    ChannelPrivacy? privacy,
    DateTime? createdAt,
    List<User>? members,
    User? creator,
    String? channelMemberId,
    DateTime? lastReadAt,
  }) {
    return Channel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      privacy: privacy ?? this.privacy,
      createdAt: createdAt ?? this.createdAt,
      members: members ?? this.members,
      creator: creator ?? this.creator,
      channelMemberId: channelMemberId ?? this.channelMemberId,
      lastReadAt: lastReadAt ?? this.lastReadAt,
    );
  }

  factory Channel.fromJson(Map<String, dynamic> json) {
    final members = ((json['expand']['channel_members_via_channel'] ?? [])
            as List)
        .map(
            (channelMember) => User.fromJson(channelMember['expand']['member']))
        .toList();

    final channelMemberId =
        ((json['expand']['channel_members_via_channel'] ?? []) as List)
            .firstWhere(
                (channelMember) => channelMember['member'] == json['userId'],
                orElse: () => <String, dynamic>{})['id'];

    final lastReadAt =
        ((json['expand']['channel_member_status_via_channel'] ?? []) as List)
            .firstWhere(
                (channelMember) => channelMember['member'] == json['userId'],
                orElse: () => <String, dynamic>{})['last_read'];
    return Channel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      privacy:
          channelPrivacyFromString[json['privacy']] ?? ChannelPrivacy.public,
      createdAt: DateTime.parse(json['created']),
      members: members,
      creator: User.fromJson(json['expand']['creator']),
      channelMemberId: channelMemberId,
      lastReadAt: lastReadAt != null ? DateTime.parse(lastReadAt) : null,
    );
  }
}
