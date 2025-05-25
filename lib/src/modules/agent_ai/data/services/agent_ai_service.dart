import '../../../../common/typedef/typedef.dart';

abstract interface class AgentAiService {
  Future<ApiResponse> askAi({required String question});
}
