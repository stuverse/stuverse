part of 'fund_home_cubit.dart';

@immutable
sealed class FundHomeState {}

final class FundHomeInitial extends FundHomeState {}

final class FundHomeLoading extends FundHomeState {}

final class FundHomeSuccess extends FundHomeState {
  final List<Projects> project;
  FundHomeSuccess({required this.project});
}

final class FundHomeError extends FundHomeState {
  final String errorMessage;
  FundHomeError({required this.errorMessage});
}
