import 'dart:io';

import '../ui/shared/extensions/index.dart';
import '../models/user.dart';

class Workspace {
  final String id;
  final String name;
  final String? imageUrl;
  final File? image;
  final DateTime createdAt;
  final User createdBy;
  List<User> members = [];

  Workspace({
    required this.id,
    required this.name,
    this.imageUrl,
    this.image,
    required this.createdAt,
    required this.createdBy,
    required this.members,
  });

  Workspace copyWith({
    String? id,
    String? name,
    String? imageUrl,
    File? image,
    DateTime? createdAt,
    User? createdBy,
    List<User>? members,
  }) {
    return Workspace(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      image: image ?? this.image,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'name': name,
  //     'imageUrl': imageUrl,
  //     'created': createdAt.toIso8601String(),
  //     'creator': createdBy.toJson(),
  //   };
  // }

  factory Workspace.fromJson(Map<String, dynamic> json) {
    return Workspace(
      id: json['id'],
      name: json['name'],
      imageUrl: json.getImageUrl('image'),
      createdAt: DateTime.parse(json['created']),
      createdBy: User.fromJson(json['expand']['creator']),
      members: (json['expand']['workspace_members_via_workspace'] as List)
          .map((workspaceMember) =>
              User.fromJson(workspaceMember['expand']['member']))
          .toList(),
    );
  }
}
