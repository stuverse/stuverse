import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'manage_mentor_request_state.dart';

class ManageMentorRequestCubit extends Cubit<ManageMentorRequestState> {
  ManageMentorRequestCubit() : super(ManageMentorRequestInitial());
  void addRequest({required int mentorId, required String description}) async {
    emit(ManageMentorRequestLoading());
    try {
      await dioClient.post('/mentor/requests/',
          data: {'description': description, 'mentor': mentorId});
      emit(ManageMentorRequestLoaded('Posted Successfully'));
    } catch (e) {
      emit(ManageMentorRequestFailure('Something went wrong'));
    }
  }

  void editRequest(
      {required int mentorId,
      required String description,
      required int id}) async {
    emit(ManageMentorRequestLoading());
    try {
      await dioClient.put('/mentor/requests/$id/',
          data: {'description': description, 'mentor': mentorId});
      emit(ManageMentorRequestLoaded('Edited Successfully'));
    } catch (e) {
      print(e);
      emit(ManageMentorRequestFailure('Something went wrong'));
    }
  }

  void deleteRequest({required int id}) async {
    emit(ManageMentorRequestLoading());
    try {
      await dioClient.delete(
        '/mentor/requests/$id/',
      );
      emit(ManageMentorRequestLoaded('Deleted Successfully'));
    } catch (e) {
      emit(ManageMentorRequestFailure('Something went wrong'));
    }
  }
}
