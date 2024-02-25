import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/features/fund/models/projects.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void getProjects() async {
    emit(HomeLoading());

    try {
      final projects = await Dio().get(
        "http://127.0.0.1:8000/api/project/",
      );

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
