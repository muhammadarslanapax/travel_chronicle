import 'dart:math';

String generateRandomString() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  const length = 20;
  String randomString = '';

  for (var i = 0; i < length; i++) {
    randomString += chars[random.nextInt(chars.length)];
  }

  return randomString;
}

String timeAgo(DateTime timestamp) {
  final now = DateTime.now();
  final difference = now.difference(timestamp);

  if (difference.inMinutes < 60) {
    final minutes = difference.inMinutes;
    return '$minutes ${minutes == 1 ? 'min ago' : 'mins ago'}';
  } else if (difference.inHours < 24) {
    final hours = difference.inHours;
    return '$hours ${hours == 1 ? 'hour ago' : 'hours ago'}';
  } else if (difference.inDays < 30) {
    final days = difference.inDays;
    return '$days ${days == 1 ? 'day ago' : 'days ago'}';
  } else if (difference.inDays < 365) {
    final months = (difference.inDays / 30).floor();
    return '$months ${months == 1 ? 'month ago' : 'months ago'}';
  } else {
    final years = (difference.inDays / 365).floor();
    return '$years ${years == 1 ? 'year ago' : 'years ago'}';
  }
}
