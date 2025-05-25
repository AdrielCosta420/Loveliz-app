import 'package:get_it/get_it.dart';

import 'data/repositories/agent_ai_repository_impl.dart';
import 'data/services/agent_ai_service.dart';
import 'data/services/agent_ai_service_impl.dart';
import 'domain/repositories/agent_ai_repository.dart';
import 'domain/usecases/send_question_ai_uc.dart';
import 'presentation/controllers/agent_ai_controller.dart';

sealed class AgentAIInjector {
  static void inject(GetIt injector) {
    injector.registerLazySingleton<AgentAiService>(() => AgentAiServiceImpl());
    injector.registerLazySingleton<AgentAiRepository>(() => AgentAiRepositoryImpl());
    injector.registerLazySingleton<SendQuestionAiUc>(() => SendQuestionAiUcImpl());
    injector.registerLazySingleton<AgentAiController>(() => AgentAiController());
  }
}