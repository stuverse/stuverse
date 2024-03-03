part of 'manage_profile_cubit.dart';

@immutable
sealed class ManageProfileState {}

final class ManageProfileInitial extends ManageProfileState {}

final class ManageProfileLoading extends ManageProfileState {}

final class ManageProfileSuccess extends ManageProfileState {


}

final class ManageProfileError extends ManageProfileState {
  final String message;

  ManageProfileError({
    required this.message,
  });
}