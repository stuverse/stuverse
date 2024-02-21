import 'package:fpdart/fpdart.dart';
import 'package:stuverse/app/app.dart';

abstract class IAuthRepo {
  Future<Either<AuthFailure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AuthFailure, Unit>> sendOtp({
    required String email,
  });

  Future<Either<AuthFailure, User>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<AuthFailure, Unit>> signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
    required String type,
  });

  Future<Either<AuthFailure, User>> getUserProfile();
}
