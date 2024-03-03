import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';

part 'skill_state.dart';

class SkillCubit extends Cubit<SkillState> {
  SkillCubit() : super(SkillInitial());

   void getSkills()async{
    emit(SkillLoading());
    try {
      final resp = await dioClient.get('/core/skills/');
      final List<Skill> skills = [];
      for (final skill in resp.data) {
        skills.add(Skill.fromJson(skill));
      }
      emit(SkillSuccess(skills: skills));
    } catch (e) {
      print(e);
      emit(SkillError(message: 'Something went wrong'));
    }

  }
}
