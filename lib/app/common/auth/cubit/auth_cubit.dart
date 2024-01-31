import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stuverse/app/app.dart';

import '../services/auth_repo.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  final _authRepo = AuthRepo();

  void signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthState.signInLoading());
    final result = await _authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        failure.maybeMap(
          authInvalidCredential: (_) =>
              emit(AuthState.signInFailure("Invalid Credentials")),
          authServerFailure: (_) => emit(AuthState.signInFailure(
              "Something went wrong. Please try again later")),
          authAccountNotVerified: (_) => emit(AuthState.accountNotVerified()),
          orElse: () => emit(AuthState.signInFailure("Something went wrong")),
        );
      },
      (user) => emit(AuthState.success(user)),
    );
  }

  void sendOtp({
    required String email,
    bool isResend = false,
  }) async {
    emit(AuthState.otpSendLoading());
    final result = await _authRepo.sendOtp(
      email: email,
    );
    result.fold(
      (failure) {
        failure.maybeMap(
          authInvalidCredential: (_) =>
              emit(AuthState.otpSendFailure("Email not found")),
          authServerFailure: (_) => emit(AuthState.otpSendFailure(
              "Something went wrong. Please try again later")),
          orElse: () => emit(AuthState.otpSendFailure("Something went wrong")),
        );
      },
      (_) => isResend
          ? emit(AuthState.otpResendSuccess())
          : emit(AuthState.otpSendSuccess()),
    );
  }

  void verifyOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthState.otpVerifyLoading());
    final result = await _authRepo.verifyOtp(
      email: email,
      otp: otp,
    );
    result.fold(
      (failure) {
        failure.maybeMap(
          authInvalidOTP: (_) =>
              emit(AuthState.otpVerifyFailure("Invalid OTP")),
          authServerFailure: (_) => emit(AuthState.otpVerifyFailure(
              "Something went wrong. Please try again later")),
          orElse: () =>
              emit(AuthState.otpVerifyFailure("Something went wrong")),
        );
      },
      (user) => emit(AuthState.success(user)),
    );
  }
}
