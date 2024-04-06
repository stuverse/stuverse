part of 'report_cubit.dart';

@immutable
sealed class ReportState {}

final class ReportInitial extends ReportState {}

final class ReportLoading extends ReportState {}

final class ReportSuccess extends ReportState {}

final class ReportError extends ReportState {
  final String message;
  ReportError({required this.message});
}
