// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthError implements Exception {
  final String message;
  final int? code;
  AuthError({
    required this.message,
    this.code,
  });
  

  
  @override
   String toString() {
    return 'AuthError: $message';
  }
}
