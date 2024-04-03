part of 'comment_report_cubit.dart';

@immutable
sealed class CommentReportState {}

final class CommentReportInitial extends CommentReportState {}

final class CommentReportLoading extends CommentReportState {}

final class CommentReportSuccess extends CommentReportState {}

final class CommentReportError extends CommentReportState {
  final String message;
  CommentReportError({required this.message});
}
