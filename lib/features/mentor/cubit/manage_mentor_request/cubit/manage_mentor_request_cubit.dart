// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// import '../../../models/mentor_request.dart';

// part 'manage_mentor_request_state.dart';

// class ManageMentorRequestCubit extends Cubit<ManageMentorRequestState> {
//   ManageMentorRequestCubit() : super(ManageMentorRequestInitial());
//   void manageMentorRequestData() async {
//     emit(ManageMentorRequestLoading());
//     try {
//       final resp = await dioClient.get('/mentor/requests');
//       final List<MentorRequest> requests = [];
//       for (final request in resp.data) {
//         requests.add(MentorRequest.fromJson(request));
//       }
//       emit(ManageMentorRequestLoaded(requests));
//     } catch (e) {
//       emit(ManageMentorRequestFailure(e.toString()));
//     }
//   }
// }
