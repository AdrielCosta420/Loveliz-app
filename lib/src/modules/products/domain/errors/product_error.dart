class ProductError implements Exception{
    final String message;
    
    ProductError(this.message);
    
    @override
    String toString() {
        return message;
    }
}