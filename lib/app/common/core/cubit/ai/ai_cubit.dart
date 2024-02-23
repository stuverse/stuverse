import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:stuverse/app/app.dart';
import 'package:stuverse/app/common/core/services/api_endpoints.dart';

part 'ai_state.dart';

class AICubit extends Cubit<AIState> {
  AICubit() : super(AIInitial());

  void generateAIDescMarkdown(
    String description,
  ) async {
    emit(AILoading());
    try {
      final response = await dioClient.post(
        AI_DESCRIPTION_API,
        data: {
          "description": description,
        },
      );
      emit(AISuccess(markdown: response.data['description']));
    } catch (e) {
      print(e);
      emit(AIError("Failed to generate AI description. Please try again."));
    }
  }

  void generateAIPrompt(
    String prompt,
  ) async {
    emit(AILoading());
    try {
      final response = await dioClient.post(
        AI_PROMPT_API,
        data: {
          "prompt": prompt,
        },
      );
      emit(AISuccess(markdown: response.data['response']));
    } catch (e) {
      print(e);
      emit(AIError("Failed to generate AI prompt. Please try again."));
    }
  }
}
