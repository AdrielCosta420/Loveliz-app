enum ProductSizesEnum {padrao, small, medium, large}

extension ProductSizesEnumExtension on ProductSizesEnum {
  String get name {
    switch (this) {
      case ProductSizesEnum.padrao:
        return 'Padrão';
      case ProductSizesEnum.small:
        return 'Pequeno';
      case ProductSizesEnum.medium:
        return 'Médio';
      case ProductSizesEnum.large:
        return 'Grande';
    }
  }
}