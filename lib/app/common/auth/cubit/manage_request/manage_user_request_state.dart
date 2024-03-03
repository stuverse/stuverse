part of 'manage_user_request_cubit.dart';

@immutable
sealed class ManageUserRequestState {}

final class ManageUserRequestInitial extends ManageUserRequestState {}

final class ManageUserRequestLoading extends ManageUserRequestState {}

final class ManageUserRequestSuccess extends ManageUserRequestState {}

final class ManageUserRequestFailure extends ManageUserRequestState {}
