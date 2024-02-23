import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

import '../../models/job_post.dart';

part 'job_search_state.dart';

class JobSearchCubit extends Cubit<JobSearchState> {
  JobSearchCubit() : super(JobSearchInitial());

  void searchJobs({String? search}) async {
    emit(JobSearchLoading());
    try {
      final response = await dioClient.get("/job/posts",
          queryParameters: {if (search != null) "search": search});
      final List<JobPost> postList = [];
      for (final post in response.data) {
        postList.add(JobPost.fromJson(post));
      }
      emit(JobSearchSuccess(postList.reversed.toList()));
    } catch (e) {
      print(e);
      emit(JobSearchError(e.toString()));
    }
  }
}
