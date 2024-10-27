import 'package:flutter/material.dart';

import '../themes/chanhub_colors.dart';
import './enums.dart';

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

const Map<SearchThreadFilter, String> searchThreadFilterString = {
  SearchThreadFilter.all: 'All Threads',
  SearchThreadFilter.unread: 'Unread',
  SearchThreadFilter.myThreads: 'My Threads',
  SearchThreadFilter.tagged: 'Tagged',
};

const Map<StatusType, Color> statusColor = {
  StatusType.error: ChanHubColors.error,
  StatusType.info: ChanHubColors.secondary,
  StatusType.warning: Colors.orange,
  StatusType.success: ChanHubColors.primary,
};
