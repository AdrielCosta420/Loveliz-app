class ChatMessage {
  final String text;
  final bool isUser;
  final bool isTypingEffect;
    final bool isLoading;
  ChatMessage({required this.text, required this.isUser, this.isTypingEffect = false, this.isLoading = false});

  ChatMessage copyWith({
    String? text,
    bool? isUser,
    bool? isTypingEffect,
    bool? isLoading,
  }) {
    return ChatMessage(
      text: text ?? this.text,
      isUser: isUser ?? this.isUser,
      isTypingEffect: isTypingEffect ?? this.isTypingEffect,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
