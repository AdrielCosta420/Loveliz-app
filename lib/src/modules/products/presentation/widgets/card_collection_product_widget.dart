import 'package:flutter/material.dart';
import '../../domain/models/collection_product.dart';

class CardCollectionProductWidget extends StatelessWidget {
  final CollectionProduct collection;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  const CardCollectionProductWidget({
    super.key,
    required this.collection,
    this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xfffffbff),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffffecf4), // rosa translúcido
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/cabide.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          collection.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          (collection.products?.length != null)
                              ? collection.products!.length > 1
                                  ? '${collection.products!.length} unidades'
                                  : '${collection.products!.length} unidade'
                              : '0 unidade',
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: onEdit,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white60,

                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(
                Icons.edit,
                size: 14,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
