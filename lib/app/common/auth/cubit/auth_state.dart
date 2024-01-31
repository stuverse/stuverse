part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.signInLoading() = _SignInLoading;
  const factory AuthState.signInFailure(String message) = _SignInFailure;

  const factory AuthState.signUpLoading() = _SignUpLoading;
  const factory AuthState.signUpFailure(String message) = _SignUpFailure;

  const factory AuthState.otpSendLoading() = _OtpSendLoading;
  const factory AuthState.otpSendFailure(String message) = _OtpSendFailure;
  const factory AuthState.otpSendSuccess() = _OtpSendSuccess;
  const factory AuthState.otpResendSuccess() = _OtpResendSuccess;

  const factory AuthState.otpVerifyLoading() = _OtpVerifyLoading;
  const factory AuthState.otpVerifyFailure(String message) = _OtpVerifyFailure;

  const factory AuthState.success(
    User user,
  ) = _Success;

  const factory AuthState.accountNotVerified() = _AccountNotVerified;
}
