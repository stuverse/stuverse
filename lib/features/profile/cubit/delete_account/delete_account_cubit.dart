import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());

  void deleteAccount({required String password}) async {
    emit(DeleteAccountLoading());
    try {
      await dioClient.post("/user/delete/", data: {"password": password});
      emit(DeleteAccountSuccess());
    } on DioException catch (e) {
      final respData = e.response?.data.toString() ?? "";
      emit(DeleteAccountError(
          message: respData.contains("Incorrect")
              ? "Incorrect password"
              : "Unable to delete now"));
    } catch (e) {
      emit(DeleteAccountError(message: "Unable to delete now"));
    }
  }
}
