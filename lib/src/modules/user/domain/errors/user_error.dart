class UserError extends Error {
  final String message;
  final String? code;

  UserError({
    required this.message,
    this.code,
  });

  @override
  String toString() {
    return 'UserError: $message';
  }
}