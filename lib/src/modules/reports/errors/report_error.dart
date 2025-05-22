
class ReportError extends Error {
  final String message;
  final int? statusCode;

  ReportError(this.message, this.statusCode);

  @override
  String toString() {
    return 'ReportError: $message\n$statusCode';
  }
  
}