import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/utils/dio_client.dart';

import '../../../models/mentor_request.dart';

part 'mentorship_request_state.dart';

class MentorshipRequestCubit extends Cubit<MentorshipRequestState> {
  MentorshipRequestCubit() : super(MentorshipRequestInitial());
  void getMentorRequestData({String? search}) async {
    emit(MentorshipRequestLoading());
    try {
      final resp = await dioClient.get('/mentor/requests',
          queryParameters: {if (search != null) 'search': search});
      final List<MentorRequest> requests = [];
      for (final request in resp.data) {
        if (request['is_reported'] == true ||
            request['is_user_blocked'] == true) continue;
        requests.add(MentorRequest.fromJson(request));
      }
      emit(MentorshipRequestLoaded(requests));
    } catch (e) {
      emit(MentorshipRequestFailure(e.toString()));
      print('error is ${e}');
    }
  }
}
