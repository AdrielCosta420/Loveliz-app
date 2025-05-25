
class AgentAIError extends Error {
  final String message;
  final int? statusCode;

  AgentAIError(this.message, this.statusCode);

  @override
  String toString() {
    return 'AgentAiError: $message';
  }
  
}