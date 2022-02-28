import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/product_model.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    Key? key,
    required this.orderProducts,
    this.onQuantityChanged,
    required this.total,
    this.onCloseOrder,
    this.onGenerateReceipt,
  }) : super(key: key);

  final List<ProductModel> orderProducts;
  final double total;
  final Function(int productId, int productQuantity)? onQuantityChanged;
  final void Function()? onCloseOrder;
  final void Function()? onGenerateReceipt;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: ListView.builder(
          itemCount: orderProducts.length,
          itemBuilder: (_, index) {
            final ProductModel orderProduct = orderProducts[index];
            return ListTile(
              contentPadding: const EdgeInsets.only(right: 16.0),
              horizontalTitleGap: 0.0,
              title: Text(orderProduct.product),
              subtitle: Text('R\$ ${orderProduct.price.toStringAsFixed(2)}'),
              trailing: Text(
                  'R\$ ${(orderProduct.price * orderProduct.quantity!).toStringAsFixed(2)}'),
              leading: SizedBox(
                width: 113,
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
                    Expanded(
                        child: Text(
                      orderProduct.quantity.toString(),
                      textAlign: TextAlign.center,
                    )),
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
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: onCloseOrder,
            child: Text('Fechar Pedido - R\$ ${total.toStringAsFixed(2)}'),
          ),
          ElevatedButton(
            onPressed: onGenerateReceipt,
            child: const Text('Comanda'),
          ),
        ],
      ),
    ]);
  }
}
