import 'package:flutter/material.dart';

import '../../../common/enums.dart';

TaskStatus getTaskStatus(DateTime deadline, DateTime? completedAt) {
  if (completedAt == null && DateTime.now().isAfter(deadline)) {
    return TaskStatus.overdue;
  }

  if (completedAt == null && DateTime.now().isBefore(deadline)) {
    return TaskStatus.inProgress;
  }

  if (completedAt != null && DateTime.now().isAfter(deadline)) {
    return TaskStatus.overdueCompleted;
  }

  if (completedAt != null && DateTime.now().isBefore(deadline)) {
    return TaskStatus.completed;
  }

  return TaskStatus.inProgress;
}

Color getTaskStatusColor(TaskStatus status, BuildContext context) {
  switch (status) {
    case TaskStatus.inProgress:
      return Theme.of(context).colorScheme.onSurface;
    case TaskStatus.completed:
      return Theme.of(context).colorScheme.primary;
    case TaskStatus.overdue:
      return Theme.of(context).colorScheme.error;
    case TaskStatus.overdueCompleted:
      return Theme.of(context).colorScheme.error.withGreen(200);
    default:
      return Theme.of(context).colorScheme.onSurface;
  }
}
