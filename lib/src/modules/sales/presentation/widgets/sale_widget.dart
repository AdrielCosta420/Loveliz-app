import 'package:flutter/material.dart';

import '../../../../common/enums/payment_method_enum.dart';
import '../../../../common/formatters/mask_date.dart';
import '../../../../common/formatters/price_format.dart';
import '../../domain/models/sale.dart';

class SaleWidget extends StatelessWidget {
  final Sale sale;
  final VoidCallback? onTap;
  const SaleWidget({super.key, required this.sale, this.onTap});

  @override
  Widget build(BuildContext context) {
    final payment = PaymentMethodEnumExtension.fromString(sale.paymentMethod?.name??'');
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '${sale.product?.model} (${sale.quantity}x)',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    PriceFormat.format(sale.totalPrice),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    MaskDate.toAbbreviationForMonth(sale.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                  Row(
                    children: [
                     Icon(payment.icon, size: 14, color: payment.color),
                      const SizedBox(width: 4),
                      Text(
                         payment.name,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
