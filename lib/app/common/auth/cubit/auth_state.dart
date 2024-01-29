part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSigninLoading extends AuthState {}

final class AuthSigninSuccess extends AuthState {}

final class AuthSigninFailure extends AuthState {
  AuthSigninFailure(this.message);
  final String message;
}

final class AuthSignupLoading extends AuthState {}

final class AuthSignupSuccess extends AuthState {}

final class AuthSignupFailure extends AuthState {
  AuthSignupFailure(this.message);
  final String message;
}
