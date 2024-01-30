part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.signInLoading() = _SignInLoading;
  const factory AuthState.signInFailure(String message) = _SignInFailure;

  const factory AuthState.signUpLoading() = _SignUpLoading;
  const factory AuthState.signUpFailure(String message) = _SignUpFailure;

  const factory AuthState.emailOtpSendLoading() = _EmailOtpLoading;
  const factory AuthState.emailOtpSendFailure(String message) =
      _EmailOtpSendFailure;
  const factory AuthState.emailOtpSendSuccess() = _EmailOtpSendSuccess;

  const factory AuthState.otpSignInLoading() = _OtpSignInLoading;
  const factory AuthState.otpSignInFailure(String message) = _OtpSignInFailure;

  const factory AuthState.success(
    User user,
  ) = _Success;

  const factory AuthState.accountNotVerified() = _AccountNotVerified;
}
