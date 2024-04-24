import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'add_edit_fund_project_state.dart';

class AddEditFundProjectCubit extends Cubit<AddEditFundProjectState> {
  AddEditFundProjectCubit() : super(AddEditFundProjectInitial());

  void addFundProject(
      {required User user,
      required String title,
      required String description,
      required double targetAmount,
      required DateTime startDate,
      required DateTime endDate,
      required String accountNumber,
      required String upiId,
      XFile? image,
      required String category}) async {
    emit(AddEditFundProjectLoading());

    try {
      final formData = FormData.fromMap({
        "user": user.id,
        "title": title,
        "description": description,
        "target_amount": targetAmount,
        "start_date": DateFormat('yyyy-MM-dd').format(startDate),
        "end_date": DateFormat('yyyy-MM-dd').format(endDate),
        "account_number": accountNumber,
        "upi_id": upiId,
        "category": category,
        if (image != null)
          "images": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });

      await dioClient.post("/fund/project/", data: formData);

      emit(AddEditFundProjectSuccess(
        message: "Successfully added fund project",
      ));
    } on DioException catch (e) {
      print(e);
      print(e.response?.data?.toString());
      emit(AddEditFundProjectError(errorMessage: e.toString()));
    } catch (e) {
      print(e);
      emit(AddEditFundProjectError(errorMessage: e.toString()));
    }
  }

  void editFundProject(
      {required User user,
      required int id,
      required String title,
      required String description,
      required double targetAmount,
      required DateTime startDate,
      required DateTime endDate,
      required String accountNumber,
      required String upiId,
      XFile? image,
      required String category}) async {
    emit(AddEditFundProjectLoading());
    try {
      final formData = FormData.fromMap({
        "user": user.id,
        "title": title,
        "description": description,
        "target_amount": targetAmount,
        "start_date": DateFormat('yyyy-MM-dd').format(startDate),
        "end_date": DateFormat('yyyy-MM-dd').format(endDate),
        "account_number": accountNumber,
        "upi_id": upiId,
        "category": category,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });

      await dioClient.patch("/fund/project/${id}/", data: formData);
      emit(AddEditFundProjectSuccess(
        message: "Successfully edited fund project",
      ));
    } catch (e) {}
  }

  void deleteFundProject({required int id}) async {
    emit(AddEditFundProjectLoading());

    try {
      await dioClient.delete("/fund/project/${id}/");
      emit(AddEditFundProjectSuccess(
        message: "Successfully deleted",
      ));
    } catch (e) {
      emit(AddEditFundProjectError(errorMessage: "Failed to delete"));
    }
  }
}
