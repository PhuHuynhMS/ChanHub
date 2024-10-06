import './user.dart';

class Task {
  final String? id;
  final String title;
  final String description;
  final User assignee;
  final DateTime? deadline;
  final bool? isCompleted;
  final DateTime? completedAt;
  final User? completedBy;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.assignee,
    this.deadline,
    this.isCompleted,
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
      isCompleted: isCompleted,
      completedAt: completedAt ?? this.completedAt,
      completedBy: completedBy ?? this.completedBy,
    );
  }
}
