import 'channel.dart';
import '../models/user.dart';

class Workspace {
  final String name;
  final User createdBy;
  final DateTime createdAt;
  final String imageUrl;
  final String id;
  List<Channel> channels = [];

  Workspace({
    required this.name,
    required this.createdBy,
    required this.createdAt,
    required this.imageUrl,
    required this.id,
    required this.channels,
  });

  Workspace copyWith(
      {String? name,
      User? createdBy,
      DateTime? createdAt,
      String? imageUrl,
      String? id,
      List<Channel>? channels}) {
    return Workspace(
        name: name ?? this.name,
        createdBy: createdBy ?? this.createdBy,
        createdAt: createdAt ?? this.createdAt,
        imageUrl: imageUrl ?? this.imageUrl,
        id: id ?? this.id,
        channels: channels ?? this.channels);
  }
}
