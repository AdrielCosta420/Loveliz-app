import 'package:flutter/material.dart';

import '../../../../injectable.dart';
import '../../domain/models/chat_message.dart';
import '../../domain/usecases/send_question_ai_uc.dart';

class AgentAiController extends ChangeNotifier {
  final sendQuestionAiUc = injector.get<SendQuestionAiUc>();

  String question = '';
  void setQuestion(String value) {
    question = value;
    notifyListeners();
  }

  String answer = '';
  void setAnswer(String value) {
    answer = value;
    notifyListeners();
  }

  final List<ChatMessage> chatMessages = [];
  bool isOpen = false;

  final Map<String, List<String>> questionMap = {
    'Insights': [
      'Quais produtos parecem estar em alta?',
      'Você consegue identificar algum padrão de compra nas vendas?',
      'O que posso concluir com base nas formas de pagamento utilizadas?',
      'Qual cliente parece estar comprando mais?',
      'Existe algum produto que foi comprado por vários clientes diferentes?',
    ],
    'Estratégia': [
      'Com base nas vendas, qual produto devo priorizar no estoque?',
      'Quais estratégias posso adotar para aumentar as vendas dos produtos menos vendidos?',
      'Qual método de pagamento devo incentivar nas promoções?',
    ],
    'Tendências': [
      'O que os dados de venda dizem sobre o comportamento dos clientes?',
      'Há indícios de sazonalidade nas compras?',
      'Você acha que há algum produto que pode estar saindo de moda?',
    ],
  };

  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void toggleOpen() {
    isOpen = !isOpen;
    resetChat();
    if (isOpen && chatMessages.isEmpty) {
      addMessage(
        ChatMessage(
          text: '👋 Olá! Me diga sobre o que você quer saber.',
          isUser: false,
          isTypingEffect: true,
        ),
      );
    }
    notifyListeners();
  }

  void resetChat() {
    question = '';
    answer = '';
    chatMessages.clear();
    notifyListeners();
  }

  void addMessage(ChatMessage message) {
    chatMessages.add(message);
    notifyListeners();
  }

  void handleCategorySelection(String category) {
    if (category.isEmpty) {
      return;
    }
    addMessage(ChatMessage(text: category, isUser: true));
    chatMessages.addAll(
      questionMap[category]!
          .map((q) => ChatMessage(text: '• $q', isUser: false))
          .toList(),
    );
    notifyListeners();
  }

  Future<void> handleQuestionTap(String question) async {
    addMessage(ChatMessage(text: question, isUser: true));
    setQuestion(question);

    // scrollToBottom();
    // notifyListeners();

    final loadingMessage = ChatMessage(
      text: 'Gerando resposta...',
      isUser: false,
      isTypingEffect: false,
      isLoading: true,
    );
    // scrollToBottom();
    // notifyListeners();
    addMessage(loadingMessage);
    await Future.delayed(const Duration(seconds: 2));
    final generatedAnswer = await sendQuestionAiUc.call(question);
    chatMessages.remove(loadingMessage);
    addMessage(
      ChatMessage(
        text: generatedAnswer,
        isUser: false,
        isTypingEffect: true,
      ),
    );

    setAnswer(generatedAnswer);

    scrollToBottom();
  }
}
