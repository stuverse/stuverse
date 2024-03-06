import 'job_post.dart';

class JobAiBest {
  String? reason;
  JobPost? bestJob;

  JobAiBest({this.reason, this.bestJob});

  factory JobAiBest.fromJson(Map<String, dynamic> json) => JobAiBest(
        reason: json['reason'] as String?,
        bestJob: json['best_job'] == null
            ? null
            : JobPost.fromJson(json['best_job'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'reason': reason,
        'best_jobs': bestJob?.toJson(),
      };
}
