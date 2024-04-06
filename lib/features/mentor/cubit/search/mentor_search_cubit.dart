import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/features/mentor/models/mentor_post.dart';

part 'mentor_search_state.dart';

class MentorSearchCubit extends Cubit<MentorSearchState> {
  MentorSearchCubit() : super(MentorSearchInitial());
  void getMentorSearchData({String? search}) async {
    emit(MentorSearchLoading());
    try {
      final resp = await dioClient.get('/mentor/posts',
          queryParameters: {if (search != null) 'search': search});
      final List<MentorPost> posts = [];
      for (final post in resp.data) {
        if (post['is_reported'] == true) continue;
        posts.add(MentorPost.fromJson(post));
      }
      emit(MentorSearchLoaded(posts));
    } catch (e) {
      emit(MentorSearchFailure(e.toString()));
      print(e);
    }
  }
}
