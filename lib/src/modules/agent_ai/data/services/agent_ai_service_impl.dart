import '../../../../common/typedef/typedef.dart';

import '../../../../core/api/ai_api_request.dart';
import '../../../../core/api/api_exception.dart';
import '../../../../injectable.dart';
import '../../domain/errors/agent_ai_error.dart';
import 'agent_ai_service.dart';

class AgentAiServiceImpl implements AgentAiService {
  final AIApiRequest api = injector.get();
  @override
  Future<ApiResponse> askAi({required String question}) async {
    try {
      return await api.post(path: 'ask', body: {'question': question});
    } on ApiException catch (e) {
      throw AgentAIError(e.message, e.statusCode ?? 500);
    } on Exception catch (e) {
      throw AgentAIError(e.toString(), 500);
    }
  }
}
