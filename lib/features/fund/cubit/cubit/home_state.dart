part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final List<Projects> project;
  HomeSuccess({required this.project});
}

final class HomeError extends HomeState {
  final String errorMessage;
  HomeError({required this.errorMessage});
}
