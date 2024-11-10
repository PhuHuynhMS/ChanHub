import 'dart:io';

import '../services/index.dart';
import './user.dart';

class Comment {
  final String? id;
  final String? content;
  List<File> mediaFiles;
  List<String> mediaUrls;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? creator;

  Comment({
    this.id,
    this.content,
    this.mediaUrls = const <String>[],
    this.mediaFiles = const <File>[],
    this.createdAt,
    this.updatedAt,
    this.creator,
  });

  Comment copyWith({
    String? id,
    String? content,
    List<File>? mediaFiles,
    List<String>? mediaUrls,
    String? creatorId,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? creator,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      mediaFiles: mediaFiles ?? this.mediaFiles,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      creator: creator ?? this.creator,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      content: json['content'],
      mediaUrls: json.getImageUrls('images'),
      createdAt: DateTime.parse(json['created']),
      updatedAt: DateTime.parse(json['updated']),
      creator: User.fromJson(json['expand']['creator']),
    );
  }
}
