import '../../../../common/result/result.dart';

import '../../domain/errors/agent_ai_error.dart';

import '../../../../injectable.dart';
import '../../domain/repositories/agent_ai_repository.dart';
import '../services/agent_ai_service.dart';

class AgentAiRepositoryImpl implements AgentAiRepository {
  final AgentAiService service = injector.get();

  @override
  Future<Result<AgentAIError, String>> askAI({required String question}) async {
    try {
      final response = await service.askAi(question: question);
      return Result.success(response['answer']);
    } on AgentAIError catch (e) {
      return Result.failure(e);
    } on Exception catch (e) {
      return Result.failure(AgentAIError(e.toString(), 500));
    }
  }
}
