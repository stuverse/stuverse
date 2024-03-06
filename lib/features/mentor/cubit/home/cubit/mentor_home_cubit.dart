import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
      for (final latestPost in resp.data['top_mentors']) {
        latestPosts.add(MentorPost.fromJson(latestPost));
      }
      emit(MentorHomeLoaded(latestPosts));
    } catch (e) {
      emit(MentorHomeFailure(e.toString()));
      print(e);
    }
  }
}
