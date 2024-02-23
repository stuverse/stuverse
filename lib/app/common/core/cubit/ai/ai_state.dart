part of 'ai_cubit.dart';

@immutable
sealed class AIState {}

final class AIInitial extends AIState {}

final class AILoading extends AIState {}

final class AISuccess extends AIState {
  final String markdown;
  AISuccess({required this.markdown});
}

final class AIError extends AIState {
  final String message;
  AIError(this.message);
}
