
class CollectionProductError implements Exception {
  final String message;
    
    CollectionProductError(this.message);
    
    @override
    String toString() {
        return message;
    }
}