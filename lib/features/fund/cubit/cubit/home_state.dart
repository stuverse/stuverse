part of 'home_cubit.dart';

@immutable
sealed class FundHomeState {}

final class HomeInitial extends FundHomeState {}

final class HomeLoading extends FundHomeState {}

final class HomeSuccess extends FundHomeState {
  final List<Projects> project;
  HomeSuccess({required this.project});
}

final class HomeError extends FundHomeState {
  final String errorMessage;
  HomeError({required this.errorMessage});
}
