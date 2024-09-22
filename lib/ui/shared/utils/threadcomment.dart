String formatTotalReplies(int totalReplies) {
  if (totalReplies == 0) {
    return 'Reply';
  } else if (totalReplies == 1) {
    return '1 reply';
  } else {
    return '$totalReplies replies';
  }
}
