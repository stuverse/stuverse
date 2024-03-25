import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/utils/dio_client.dart';

part 'add_edit_fund_project_state.dart';

class AddEditFundProjectCubit extends Cubit<AddEditFundProjectState> {
  AddEditFundProjectCubit() : super(AddEditFundProjectInitial());

  void addEditFundProject(
      {required String title,
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
        "title": title,
        "description": description,
        "target_amount": targetAmount,
        "start_date": startDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "account_number": accountNumber,
        "upi_id": upiId,
        "category": category,
        if (image != null)
          "image": await MultipartFile.fromFile(
            image.path,
            filename: image.name,
          )
      });

      final response = await dioClient.post("/fund/project/", data: formData);

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
}
