import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PaymentMethodEnum { pix, dinheiro, credito, debito, outros }

extension PaymentMethodEnumExtension on PaymentMethodEnum {
  String get name {
    switch (this) {
      case PaymentMethodEnum.pix:
        return 'Pix';
      case PaymentMethodEnum.dinheiro:
        return 'Dinheiro';
      case PaymentMethodEnum.credito:
        return 'Cartão de crédito';
      case PaymentMethodEnum.debito:
        return 'Cartão de débito';
      case PaymentMethodEnum.outros:
        return 'Outros';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentMethodEnum.pix:
        return FontAwesomeIcons.pix;
      case PaymentMethodEnum.dinheiro:
        return FontAwesomeIcons.moneyBill1;
      case PaymentMethodEnum.credito:
      case PaymentMethodEnum.debito:
        return FontAwesomeIcons.creditCard;
      case PaymentMethodEnum.outros:
        return Icons.payments;
    }
  }

  Color get color {
    switch (this) {
      case PaymentMethodEnum.pix:
        return const Color.fromARGB(255, 46, 231, 176);
      case PaymentMethodEnum.dinheiro:
        return Colors.green;
      case PaymentMethodEnum.credito:
        return Colors.blue;
      case PaymentMethodEnum.debito:
        return const Color(0XFFdfe300);
      // return const Color.fromARGB(255, 223, 177, 42);
      case PaymentMethodEnum.outros:
        return Colors.grey;
    }
  }

  static PaymentMethodEnum fromString(String method) {
    switch (method) {
      case 'Pix':
        return PaymentMethodEnum.pix;
      case 'Dinheiro':
        return PaymentMethodEnum.dinheiro;
      case 'Cartão de crédito':
        return PaymentMethodEnum.credito;
      case 'Cartão de débito':
        return PaymentMethodEnum.debito;
      default:
        return PaymentMethodEnum.outros;
    }
  }
}
