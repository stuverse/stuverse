import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:stuverse/app/utils/dio_client.dart';
import 'package:stuverse/features/fund/models/projects.dart';

part 'fund_home_state.dart';

class FundHomeCubit extends Cubit<FundHomeState> {
  FundHomeCubit() : super(FundHomeInitial());

  void getProjects({
    String? search,
    String? category,
  }) async {
    emit(FundHomeLoading());

    try {
      final projects = await dioClient.get("/fund/project/", queryParameters: {
        if (search != null) "search": search,
        if (category != null) "category": category,
      });

      final List<Projects> projectList = [];

      for (final project in projects.data) {
        projectList.add(Projects.fromJson(project));
      }

      emit(FundHomeSuccess(project: projectList.reversed.toList()));
    } catch (e) {
      emit(FundHomeError(errorMessage: e.toString()));
    }
  }
}
