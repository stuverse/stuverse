import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_failures.freezed.dart';

@freezed
class AuthFailure with _$AuthFailure {
  const factory AuthFailure.authClientFailure() = AuthClientFailure;
  const factory AuthFailure.authServerFailure() = AuthServerFailure;
  const factory AuthFailure.authNetworkFailure() = AuthNetworkFailure;
  const factory AuthFailure.authInvalidCredential() = AuthInvalidCredential;
  const factory AuthFailure.authAccountNotFound() = AuthAccountNotFound;
  const factory AuthFailure.authAccountNotVerified() = AuthAccountNotVerified;
  const factory AuthFailure.authInvalidOTP() = AuthInvalidOTP;
  const factory AuthFailure.authInvalidEmailDomain() = AuthInvalidEmailDomain;
  const factory AuthFailure.authEmailAlreadyInUse() = AuthEmailAlreadyInUse;
}
