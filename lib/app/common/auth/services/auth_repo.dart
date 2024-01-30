import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stuverse/app/app.dart';

import 'api_endpoints.dart';
import 'i_auth_repo.dart';

class AuthRepo implements IAuthRepo {
  @override
  Future<Either<AuthFailure, User>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final resp = await dioClient.post(
        SIGN_IN_API,
        data: {
          'email': email,
          'password': password,
        },
      );
      final user = User.fromJson(resp.data);
      return right(user);
    } on DioException catch (e) {
      log(e.toString());
      if (e.response?.statusCode == 404) {
        return left(const AuthFailure.authInvalidCredential());
      }
      if (e.response?.statusCode == 423) {
        return left(const AuthFailure.authAccountNotVerified());
      }
      return left(const AuthFailure.authServerFailure());
    } catch (e) {
      return left(const AuthFailure.authClientFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendOtp({required String email}) async {
    try {
      final resp = await dioClient.post(
        SEND_OTP_API,
        data: {
          'email': email,
        },
      );
      final user = User.fromJson(resp.data);
      return right(unit);
    } on DioException catch (e) {
      log(e.toString());
      if (e.response?.statusCode == 400) {
        if (e.response?.data['non_field_errors']) {
          return left(const AuthFailure.authInvalidCredential());
        }
      }
      return left(const AuthFailure.authServerFailure());
    } catch (e) {
      return left(const AuthFailure.authClientFailure());
    }
  }
}
