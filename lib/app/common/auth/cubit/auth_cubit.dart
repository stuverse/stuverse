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
  }) async {
    emit(AuthState.emailOtpSendLoading());
    final result = await _authRepo.sendOtp(
      email: email,
    );
    result.fold(
      (failure) {
        failure.maybeMap(
          authInvalidCredential: (_) =>
              emit(AuthState.emailOtpSendFailure("Email not found")),
          authServerFailure: (_) => emit(AuthState.emailOtpSendFailure(
              "Something went wrong. Please try again later")),
          orElse: () =>
              emit(AuthState.emailOtpSendFailure("Something went wrong")),
        );
      },
      (_) => emit(AuthState.emailOtpSendSuccess()),
    );
  }
}
