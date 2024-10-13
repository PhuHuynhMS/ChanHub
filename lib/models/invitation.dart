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
}
