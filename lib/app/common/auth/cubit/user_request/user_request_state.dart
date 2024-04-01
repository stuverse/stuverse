part of 'user_request_cubit.dart';

@immutable
sealed class UserRequestState {}

final class UserRequestInitial extends UserRequestState {}

final class UserRequestLoading extends UserRequestState {}

final class UserRequestSuccess extends UserRequestState {
  final List<User> requestUsersSelection;

  UserRequestSuccess(this.requestUsersSelection);
}

final class UserRequestFailure extends UserRequestState {}
