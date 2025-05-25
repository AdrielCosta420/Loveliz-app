import 'package:flutter/material.dart';

import '../../../../injectable.dart';
import '../controllers/agent_ai_controller.dart';
import 'assistant_response_widget.dart';

class AssistantFabWidget extends StatefulWidget {
  const AssistantFabWidget({super.key});

  @override
  State<AssistantFabWidget> createState() => _AssistantFabWidgetState();
}

class _AssistantFabWidgetState extends State<AssistantFabWidget> {
  final aiController = injector.get<AgentAiController>();
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: aiController,
      builder: (_, __) {
        return Stack(
          children: [
            if (aiController.isOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    aiController.toggleOpen();
                    aiController.resetChat();
                  },
                  child: Container(color: Colors.black.withValues(alpha: 0.4)),
                ),
              ),
            if (aiController.isOpen)
              Positioned(
                bottom: 80,
                right: 20,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.65,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Assistente Virtual',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.smart_toy,
                            color: Theme.of(context).primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: ListView.builder(
                          controller: aiController.scrollController,
                          padding: const EdgeInsets.all(8),
                          itemCount: aiController.chatMessages.length,
                          itemBuilder: (_, index) {
                            final msg = aiController.chatMessages[index];
                            final isQuestionOption = msg.text.startsWith('• ');
                            final questionText = msg.text.replaceFirst(
                              '• ',
                              '',
                            );

                            return Align(
                              alignment:
                                  msg.isUser
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: GestureDetector(
                                onTap:
                                    isQuestionOption
                                        ? () => aiController.handleQuestionTap(
                                          questionText,
                                        )
                                        : null,
                                child:
                                    msg.isUser || isQuestionOption
                                        ? Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                msg.isUser
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                        .withValues(alpha: 0.7)
                                                    : Colors.grey.shade100,
                                            borderRadius: BorderRadius.only(
                                              topLeft: const Radius.circular(
                                                12,
                                              ),
                                              topRight: const Radius.circular(
                                                12,
                                              ),
                                              bottomLeft:
                                                  msg.isUser
                                                      ? const Radius.circular(
                                                        12,
                                                      )
                                                      : const Radius.circular(
                                                        0,
                                                      ),
                                              bottomRight:
                                                  msg.isUser
                                                      ? const Radius.circular(0)
                                                      : const Radius.circular(
                                                        12,
                                                      ),
                                            ),
                                          ),
                                          child: Text(msg.text),
                                        )
                                        : Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 4,
                                          ),
                                          child: AssistantResponseWidget(
                                            message: msg.text,
                                            isTypingEffect: msg.isTypingEffect,
                                            isUser: msg.isUser,
                                            // isLoading: msg.isLoading,
                                          ),
                                        ),
                              ),
                            );
                          },
                        ),
                      ),

                      Wrap(
                        spacing: 6,
                        children:
                            aiController.questionMap.keys.map((category) {
                              return TextButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                onPressed:
                                    () => aiController.handleCategorySelection(
                                      category,
                                    ),
                                child: Text(
                                  category,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'Toque em uma pergunta acima para obter resposta.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  aiController.toggleOpen();
                },
                child: Icon(aiController.isOpen ? Icons.close : Icons.chat),
              ),
            ),
          ],
        );
      },
    );
  }
}
