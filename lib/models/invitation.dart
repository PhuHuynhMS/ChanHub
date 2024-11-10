import './workspace.dart';
import './user.dart';

class Invitation {
  final String id;
  final Workspace workspace;
  final User creator;
  final DateTime createdAt;
  Invitation({
    required this.id,
    required this.workspace,
    required this.creator,
    required this.createdAt,
  });

  Invitation copyWith({
    String? id,
    Workspace? workspace,
    User? creator,
    DateTime? createdAt,
  }) {
    return Invitation(
      id: id ?? this.id,
      workspace: workspace ?? this.workspace,
      creator: creator ?? this.creator,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Invitation.fromJson(Map<String, dynamic> json) {
    return Invitation(
      id: json['id'],
      workspace: Workspace.fromJson(json['expand']['workspace']),
      creator: User.fromJson(json['expand']['workspace']['expand']['creator']),
      createdAt: DateTime.parse(json['created']),
    );
  }
}
