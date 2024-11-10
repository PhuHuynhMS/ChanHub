import 'dart:io';

import '../services/index.dart';
import '../common/constants.dart';
import '../common/enums.dart';
import './comment.dart';
import './reaction.dart';
import './user.dart';
import './task.dart';

class Thread {
  final String? id;
  final ThreadType type;
  final String? content;
  List<String> mediaUrls;
  List<File> mediaFiles;
  DateTime? createdAt;
  DateTime? updatedAt;
  final List<Reaction> reactions;
  List<Comment> comments;
  List<Task> tasks;
  User? creator;

  Thread({
    this.id,
    this.type = ThreadType.message,
    this.content,
    this.mediaUrls = const <String>[],
    this.mediaFiles = const <File>[],
    this.createdAt,
    this.creator,
    this.updatedAt,
    this.reactions = const <Reaction>[],
    this.comments = const <Comment>[],
    this.tasks = const <Task>[],
  });

  Thread copyWith({
    String? id,
    ThreadType? type,
    String? content,
    List<String>? mediaUrls,
    List<File>? mediaFiles,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Reaction>? reactions,
    List<Comment>? comments,
    List<Task>? tasks,
    User? creator,
  }) {
    return Thread(
      id: id ?? this.id,
      type: type ?? this.type,
      content: content ?? this.content,
      mediaUrls: mediaUrls ?? this.mediaUrls,
      mediaFiles: mediaFiles ?? this.mediaFiles,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      reactions: reactions ?? this.reactions,
      comments: comments ?? this.comments,
      tasks: tasks ?? this.tasks,
      creator: creator ?? this.creator,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': threadTypeString[type],
      'content': content,
    };
  }

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json['id'],
      type: threadTypeFromString[json['type']] ?? ThreadType.message,
      content: json['content'],
      mediaUrls: json.getImageUrls('images'),
      createdAt: DateTime.parse(json['created']),
      updatedAt: DateTime.parse(json['updated']),
      creator: User.fromJson(json['expand']['creator']),
      reactions: json['expand']['thread_reactions_via_thread'] == null
          ? []
          : (json['expand']['thread_reactions_via_thread']
                  as List<Map<String, dynamic>>)
              .map(
                (reaction) => Reaction.fromJson(reaction),
              )
              .toList(),
      comments: json['expand']['comments_via_thread'] == null
          ? []
          : (json['expand']['comments_via_thread']
                  as List<Map<String, dynamic>>)
              .map(
                (reaction) => Comment.fromJson(reaction),
              )
              .toList(),
      tasks: json['expand']['thread_tasks_via_thread'] == null
          ? []
          : (json['expand']['thread_tasks_via_thread']
                  as List<Map<String, dynamic>>)
              .map(
                (task) => Task.fromJson(task),
              )
              .toList(),
    );
  }
}
