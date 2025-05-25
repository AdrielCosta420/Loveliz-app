import '../../../../common/result/result.dart';
import '../errors/agent_ai_error.dart';

abstract interface class AgentAiRepository {
  Future<Result<AgentAIError, String>> askAI({required String question});
}
