import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

import '../../models/job_ai_best.dart';

part 'job_ai_search_state.dart';

class JobAiSearchCubit extends Cubit<JobAiSearchState> {
  JobAiSearchCubit() : super(JobAiSearchInitial());

  void getBestJobsAI() async {
    emit(JobAiSearchLoading());

    try {
      final bestJobs = await dioClient.get("/job/ai/best/");

      emit(JobAiSearchSuccess(result: JobAiBest.fromJson(bestJobs.data)));
    } catch (e) {
      emit(JobAiSearchError(
          message: "High AI traffic, please try again later."));
    }
  }
}
