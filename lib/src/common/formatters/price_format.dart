sealed class PriceFormat {
  static String format(double price) {
    final formattedPrice = price.toStringAsFixed(2).replaceAll('.', ',');
    return 'R\$ ${formattedPrice.replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (match) => '${match[1]}.')}';
  }
}