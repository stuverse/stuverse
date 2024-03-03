part of 'skill_cubit.dart';

@immutable
sealed class SkillState {}

final class SkillInitial extends SkillState {}

final class SkillLoading extends SkillState {}

final class SkillSuccess extends SkillState {
  final List<Skill> skills;

  SkillSuccess({
    required this.skills,
  });
}

final class SkillError extends SkillState {
  final String message;

  SkillError({
    required this.message,
  });
}