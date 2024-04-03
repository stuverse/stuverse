import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/utils/dio_client.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  void resetPassword(
      {required String password, required String password2}) async {
    emit(ResetPasswordLoading());
    try {
      await dioClient.post("/user/changepassword/",
          data: {"password": password, "password2": password2});
      emit(ResetPasswordSuccess());
    } on DioException catch (_) {
      emit(ResetPasswordError());
    } catch (e) {
      emit(ResetPasswordError());
    }
  }
}
