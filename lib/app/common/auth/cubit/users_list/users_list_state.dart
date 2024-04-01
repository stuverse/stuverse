part of 'users_list_cubit.dart';

@immutable
sealed class UsersListState {}

final class UsersListInitial extends UsersListState {}

final class UsersListLoading extends UsersListState {}

final class UsersListSuccess extends UsersListState {
  final List<User> usersList;

  UsersListSuccess(this.usersList);
}

final class UsersListFailure extends UsersListState {
  final String message;

  UsersListFailure(this.message);
}
