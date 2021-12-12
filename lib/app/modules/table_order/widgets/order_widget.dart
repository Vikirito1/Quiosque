import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/product_model.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    Key? key,
    required this.orderProducts,
    this.onQuantityChanged,
  }) : super(key: key);

  final List<ProductModel> orderProducts;
  final Function(int productId, int productQuantity)? onQuantityChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orderProducts.length,
      itemBuilder: (_, index) {
        final ProductModel orderProduct = orderProducts[index];
        return ListTile(
          contentPadding: const EdgeInsets.only(right: 16.0),
          title: Text(orderProduct.product),
          subtitle: Text('R\$ ${orderProduct.price.toStringAsFixed(2)}'),
          trailing: Text(
              'R\$ ${(orderProduct.price * orderProduct.quantity!).toStringAsFixed(2)}'),
          leading: SizedBox(
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: orderProduct.quantity == 0
                      ? null
                      : () {
                          onQuantityChanged?.call(
                            orderProduct.id,
                            (orderProduct.quantity! - 1),
                          );
                        },
                  icon: const Icon(
                    Icons.remove_circle,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                Text(orderProduct.quantity.toString()),
                IconButton(
                  onPressed: () {
                    onQuantityChanged?.call(
                      orderProduct.id,
                      (orderProduct.quantity! + 1),
                    );
                  },
                  icon: const Icon(
                    Icons.add_circle,
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
