part of 'users_selection_cubit.dart';

@immutable
sealed class UsersSelectionState {}

final class UsersSelectionInitial extends UsersSelectionState {}

final class UsersSelectionLoading extends UsersSelectionState {}

final class UsersSelectionSuccess extends UsersSelectionState {
  final List<MiniUser> usersList;

  UsersSelectionSuccess(this.usersList);
}

final class UsersSelectionFailure extends UsersSelectionState {
  final String message;

  UsersSelectionFailure(this.message);
}
