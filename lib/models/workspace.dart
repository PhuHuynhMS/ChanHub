import 'dart:io';

import '../ui/shared/extensions/index.dart';
import '../models/user.dart';

class Workspace {
  final String id;
  final String name;
  final String? imageUrl;
  final File? image;
  final DateTime createdAt;
  final User creator;
  List<User> members = [];

  String? workspaceMemberId;

  Workspace(
      {required this.id,
      required this.name,
      this.imageUrl,
      this.image,
      required this.createdAt,
      required this.creator,
      required this.members,
      this.workspaceMemberId});

  Workspace copyWith({
    String? id,
    String? name,
    String? imageUrl,
    File? image,
    DateTime? createdAt,
    User? creator,
    List<User>? members,
    String? workspaceMemberId,
  }) {
    return Workspace(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      creator: creator ?? this.creator,
      members: members ?? this.members,
      workspaceMemberId: workspaceMemberId ?? this.workspaceMemberId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  factory Workspace.fromJson(Map<String, dynamic> json) {
    final workspaceMemberId = ((json['expand']
                ['workspace_members_via_workspace'] ??
            []) as List)
        .firstWhere(
            (workspaceMember) => workspaceMember['member'] == json['userId'],
            orElse: () => <String, dynamic>{})['id'];
    return Workspace(
      id: json['id'],
      name: json['name'],
      imageUrl: json.getImageUrl('image'),
      createdAt: DateTime.parse(json['created']),
      creator: User.fromJson(json['expand']['creator']),
      members:
          ((json['expand']['workspace_members_via_workspace'] ?? []) as List)
              .map((workspaceMember) =>
                  User.fromJson(workspaceMember['expand']['member']))
              .toList(),
      workspaceMemberId: workspaceMemberId,
    );
  }
}
