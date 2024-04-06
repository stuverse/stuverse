class ReportType {
  static const String spam = 'spam';
  static const String inappropriate = 'inappropriate';
  static const String offensive = 'offensive';
  static const String other = 'other';

  static List<String> get values => [spam, inappropriate, offensive, other];
}

class ReportItem {
  static const String thread = 'thread';
  static const String comment = 'comment';
  static const String user = 'user';
  static const String mentorshipRequest = 'mentorship_request';
  static const String mentorshipPost = 'mentorship_post';

  static List<String> get values => [thread, comment, user, mentorshipRequest, mentorshipPost];
}
