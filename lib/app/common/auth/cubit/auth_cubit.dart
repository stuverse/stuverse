import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/models/user/token.dart';

import '../services/auth_repo.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());

  final _authRepo = AuthRepo();

  //! Sign In
  void signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthState.signInLoading());
    final result = await _authRepo.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    result.fold((failure) {
      failure.maybeMap(
        authInvalidCredential: (_) =>
            emit(AuthState.signInFailure("Invalid Credentials")),
        authServerFailure: (_) => emit(AuthState.signInFailure(
            "Something went wrong. Please try again later")),
        authAccountNotVerified: (_) => emit(AuthState.accountNotVerified()),
        orElse: () => emit(AuthState.signInFailure("Something went wrong")),
      );
    }, (user) {
      storeToken(token: user.token);
      emit(AuthState.success(user));
    });
  }

  //! Send Otp
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

  //! Verify Otp
  void verifyOtp({
    required String email,
    required String otp,
  }) async {
    emit(AuthState.otpVerifyLoading());
    final result = await _authRepo.verifyOtp(
      email: email,
      otp: otp,
    );
    result.fold((failure) {
      failure.maybeMap(
        authInvalidOTP: (_) => emit(AuthState.otpVerifyFailure("Invalid OTP")),
        authServerFailure: (_) => emit(AuthState.otpVerifyFailure(
            "Something went wrong. Please try again later")),
        orElse: () => emit(AuthState.otpVerifyFailure("Something went wrong")),
      );
    }, (user) {
      storeToken(token: user.token);
      emit(AuthState.success(user));
    });
  }

  void signUpWithEmailAndPassword(
      {required String email,
      required String name,
      required String password,
      required String type,
      String? about}) async {
    emit(AuthState.signUpLoading());
    final result = await _authRepo.signUpWithEmailAndPassword(
        email: email, name: name, password: password, type: type, about: about);
    result.fold(
      (failure) {
        failure.maybeMap(
          authEmailAlreadyInUse: (_) =>
              emit(AuthState.signInFailure("Email already in use")),
          authServerFailure: (_) => emit(AuthState.signInFailure(
              "Something went wrong. Please try again later")),
          authInvalidEmailDomain: (_) =>
              emit(AuthState.signInFailure("Use your college email")),
          orElse: () => emit(AuthState.signInFailure("Something went wrong")),
        );
      },
      (_) => emit(AuthState.signUpSuccess()),
    );
  }

  void storeToken({Token? token}) async {
    if (token != null) {
      final _sharedPref = await SharedPreferences.getInstance();
      await _sharedPref.setString('token_refresh', token.refresh ?? "");
      await _sharedPref.setString('token_access', token.access ?? "");
    }
  }
}
