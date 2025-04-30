class SaleError extends Error {
  final String message;

  SaleError(this.message);

  @override
  String toString() {
    return 'SaleError: $message';
  }
}
