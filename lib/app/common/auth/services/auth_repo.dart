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
        if (e.response?.data['non_field_errors'] != null) {
          return left(const AuthFailure.authInvalidCredential());
        }
      }
      return left(const AuthFailure.authServerFailure());
    } catch (e) {
      return left(const AuthFailure.authClientFailure());
    }
  }

  @override
  Future<Either<AuthFailure, User>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final resp = await dioClient.post(
        VERIFY_OTP_API,
        data: {
          'email': email,
          'otp': otp,
        },
      );
      final user = User.fromJson(resp.data);
      return right(user);
    } on DioException catch (e) {
      log(e.toString());
      if (e.response?.statusCode == 400) {
        if (e.response?.data['non_field_errors'] != null) {
          return left(const AuthFailure.authInvalidOTP());
        }
      }
      return left(const AuthFailure.authServerFailure());
    } catch (e) {
      return left(const AuthFailure.authClientFailure());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signUpWithEmailAndPassword({
    required String email,
    required String name,
    required String password,
    required String type,
    String? about,
  }) async {
    try {
      final resp = await dioClient.post(
        SIGN_UP_API,
        data: {
          'email': email,
          'name': name,
          'password': password,
          'type': type,
          if (about != null) 'about': about
        },
      );

      return right(unit);
    } on DioException catch (e) {
      log(e.toString());
      if (e.response?.statusCode == 400) {
        if (e.response?.data['email'] != null) {
          return left(const AuthFailure.authEmailAlreadyInUse());
        }
        if (e.response?.data['non_field_errors'] != null) {
          if ((e.response?.data['non_field_errors'][0] ?? "")
              .toString()
              .contains("You are not a Student of MEA Engineering College")) {
            return left(const AuthFailure.authInvalidEmailDomain());
          }
        }
      }
      return left(const AuthFailure.authServerFailure());
    } catch (e) {
      return left(const AuthFailure.authClientFailure());
    }
  }

  @override
  Future<Either<AuthFailure, User>> getUserProfile() async {
    try {
      final resp = await dioClient.get(
        USER_PROFILE_API,
      );
      final user = User.fromJson(resp.data);
      return right(user);
    } on DioException catch (_) {
      return left(const AuthFailure.authServerFailure());
    } catch (e) {
      return left(const AuthFailure.authClientFailure());
    }
  }
}
