import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quiosque/app/core/models/product_model.dart';

import '../../../../../core/utils/formatters.dart';

class ReceiptTableContentWidget extends StatelessWidget {
  ReceiptTableContentWidget({
    Key? key,
    required this.orderProducts,
  }) : super(key: key);

  final List<ProductModel> orderProducts;
  final NumberFormat moneyFormatterWithoutCurrency =
      Formatters.moneyFormatterWithoutSymbol();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: orderProducts
          .map((product) => Row(
                children: [
                  Expanded(
                    child: Text(
                      product.quantity!.toString(),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Text(product.product),
                    flex: 7,
                  ),
                  Expanded(
                    child: Text(
                      moneyFormatterWithoutCurrency.format(product.price),
                      textAlign: TextAlign.end,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Text(
                      moneyFormatterWithoutCurrency
                          .format(product.price * product.quantity!),
                      textAlign: TextAlign.end,
                    ),
                    flex: 2,
                  ),
                ],
              ))
          .toList(),
    );
  }
}
