import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final diff = now.difference(dateTime);

  if (diff.inDays == 1) {
    return 'yesterday';
  } else if (diff.inDays > 1 && diff.inDays < 7) {
    return '${diff.inDays}d ago';
  } else if (diff.inDays >= 7 && diff.inDays < 30) {
    return '${(diff.inDays / 7).floor()}w ago';
  } else if (diff.inDays >= 30 && diff.inDays < 365) {
    return '${(diff.inDays / 30).floor()}m ago';
  } else if (diff.inDays >= 365) {
    return '${(diff.inDays / 365).floor()}y ago';
  } else if (diff.inHours > 0) {
    return '${diff.inHours}h ago';
  } else if (diff.inMinutes > 0) {
    return '${diff.inMinutes}m ago';
  } else {
    return 'now';
  }
}

String formatDeadlineTime(DateTime? dateTime) {
  if (dateTime != null) {
    return DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
  } else {
    return 'No deadline';
  }
}
