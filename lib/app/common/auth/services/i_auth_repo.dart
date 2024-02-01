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
}
