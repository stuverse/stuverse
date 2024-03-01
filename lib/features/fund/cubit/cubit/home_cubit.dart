import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:stuverse/app/utils/dio_client.dart';
import 'package:stuverse/features/fund/models/projects.dart';

part 'home_state.dart';

class FundHomeCubit extends Cubit<FundHomeState> {
  FundHomeCubit() : super(HomeInitial());

  void getProjects() async {
    emit(HomeLoading());

    try {
      final projects = await dioClient.get("/fund/project/");

      final List<Projects> projectList = [];

      for (final project in projects.data) {
        projectList.add(Projects.fromJson(project));
      }

      emit(HomeSuccess(project: projectList));
    } catch (e) {
      emit(HomeError(errorMessage: e.toString()));
    }
  }
}
