import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/utils/dio_client.dart';

import '../../../models/mentor_request.dart';

part 'mentorship_request_state.dart';

class MentorshipRequestCubit extends Cubit<MentorshipRequestState> {
  MentorshipRequestCubit() : super(MentorshipRequestInitial());
  void getMentorRequestData() async {
    emit(MentorshipRequestLoading());
    try {
      final resp= await dioClient.get('/mentor/requests');
      final List<MentorRequest> requests = [];
      for(final request in resp.data){
        requests.add(MentorRequest.fromJson(request));
    }
    emit(MentorshipRequestLoaded(requests));
    }
     catch (e) {
      emit(MentorshipRequestFailure(e.toString()));
    }
}
}