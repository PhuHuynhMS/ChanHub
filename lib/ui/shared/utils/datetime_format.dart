import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  dateTime = dateTime.toLocal();

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

String formatTime(DateTime dateTime) {
  dateTime = dateTime.toLocal();
  return DateFormat('HH:mm').format(dateTime);
}

String formatDeadlineTime(DateTime? dateTime) {
  dateTime = dateTime?.toLocal();
  if (dateTime != null) {
    return DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
  } else {
    return 'No deadline';
  }
}

String nth(int day) {
  return [
    "th",
    "st",
    "nd",
    "rd"
  ][(day > 3 && day < 21) || day % 10 > 3 ? 0 : day % 10];
}

String formatMilestoneTime(DateTime dateTime) {
  dateTime = dateTime.toLocal();

  final currentTime = DateTime.now();
  final formattedDay = DateFormat('EEE, MMM').format(dateTime);
  final dayWithSuffix = dateTime.day.toString() + nth(dateTime.day);

  // Today
  if (dateTime.day == currentTime.day &&
      dateTime.month == currentTime.month &&
      dateTime.year == currentTime.year) {
    return 'Today';
  }

  // Last year
  if (dateTime.year < currentTime.year) {
    return '$formattedDay $dayWithSuffix ${dateTime.year}';
  }

  // This year
  return '$formattedDay $dayWithSuffix';
}

bool isDifferentDay(DateTime? dateTime1, DateTime? dateTime2) {
  if (dateTime1 == null || dateTime2 == null) {
    return true;
  }
  return dateTime1.day != dateTime2.day ||
      dateTime1.month != dateTime2.month ||
      dateTime1.year != dateTime2.year;
}
