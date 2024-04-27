import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/mentor/models/mentor_request.dart';

import '../../../../../app/utils/dio_client.dart';
import '../../../models/mentor_post.dart';

part 'mentor_home_state.dart';

class MentorHomeCubit extends Cubit<MentorHomeState> {
  MentorHomeCubit() : super(MentorHomeInitial());
  void getMentorHomeData() async {
    emit(MentorHomeLoading());
    try {
      final resp = await dioClient.get('/mentor/home');
      final List<MentorPost> latestPosts = [];
      final List<MentorRequest> latestRequests = [];
      for (final latestPost in resp.data['top_mentors']) {
        if (latestPost['is_reported'] == true ||
            latestPost['is_user_blocked'] == true) continue;
        latestPosts.add(MentorPost.fromJson(latestPost));
      }
      for (final latestRequest in resp.data['latest_requests']) {
        if (latestRequest['is_reported'] == true ||
            latestRequest['is_user_blocked'] == true) continue;
        latestRequests.add(MentorRequest.fromJson(latestRequest));
      }
      emit(MentorHomeLoaded(latestPosts, latestRequests));
    } catch (e) {
      emit(MentorHomeFailure(e.toString()));
      print(e);
    }
  }
}
