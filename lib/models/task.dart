import './user.dart';

class Task {
  final String? id;
  final String title;
  final String description;
  final User? assignee;
  final DateTime? deadline;
  final bool isCompleted;
  final DateTime? completedAt;
  final User? completedBy;

  Task({
    this.id,
    this.title = '',
    this.description = '',
    this.assignee,
    this.deadline,
    this.isCompleted = false,
    this.completedAt,
    this.completedBy,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    User? assignee,
    DateTime? deadline,
    bool? isCompleted,
    DateTime? completedAt,
    User? completedBy,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignee: assignee ?? this.assignee,
      deadline: deadline ?? this.deadline,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      completedBy: completedBy ?? this.completedBy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'assignee': assignee?.id,
      'deadline': deadline?.toUtc().toIso8601String(),
      'is_completed': isCompleted,
      'completed_at': completedAt?.toUtc().toIso8601String(),
      'completed_by': completedBy?.id,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      assignee: json['expand']['assignee'] != null
          ? User.fromJson(json['expand']['assignee'] as Map<String, dynamic>)
          : null,
      deadline: json['deadline'] != null && json['deadline'] != ''
          ? DateTime.parse(json['deadline'] as String)
          : null,
      isCompleted: json['is_completed'] as bool,
      completedAt: json['completed'] != null && json['completed'] != ''
          ? DateTime.parse(json['completed'] as String)
          : null,
      completedBy: json['expand']['completed_by'] != null
          ? User.fromJson(
              json['expand']['completed_by'] as Map<String, dynamic>)
          : null,
    );
  }
}
