import '../../../../injectable.dart';
import '../repositories/agent_ai_repository.dart';

abstract interface class SendQuestionAiUc {
  Future<String> call(String question);
}

class SendQuestionAiUcImpl implements SendQuestionAiUc {
  final AgentAiRepository repository = injector.get();

  @override
  Future<String> call(String question) async {
    final result = await repository.askAI(question: question);
    return result.fold(
      (error) => 'Erro ao gerar resposta: ${error.message}',
      (response) => response,
    );
  }
}
