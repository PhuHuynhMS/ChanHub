import 'enums.dart';

const Map<String, ReactionType> reactionType = {
  'like': ReactionType.like,
  'love': ReactionType.love,
  'haha': ReactionType.haha,
  'seen': ReactionType.seen,
  'completed': ReactionType.completed,
  'dislike': ReactionType.dislike,
};

const Map<TaskStatus, String> taskStatusString = {
  TaskStatus.inProgress: 'In Progress',
  TaskStatus.completed: 'Completed',
  TaskStatus.overdue: 'Overdue',
  TaskStatus.overdueCompleted: 'Overdue Completed',
};

const String defaultUserAvatarUrl = 'https://picsum.photos/300/300';
