String truncate(String text, int length) {
  if (text.length <= length) {
    return text;
  }
  return '${text.substring(0, length)}...';
}

String formatTotalReplies(int totalReplies) {
  if (totalReplies == 0) {
    return 'Reply';
  } else if (totalReplies == 1) {
    return '1 reply';
  } else {
    return '$totalReplies replies';
  }
}
