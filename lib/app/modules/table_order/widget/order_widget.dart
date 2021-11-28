import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/product_model.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key, required this.orderProducts}) : super(key: key);

  final List<ProductModel> orderProducts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orderProducts.length,
      itemBuilder: (_, index) {
        final ProductModel orderProduct = orderProducts[index];
        return ListTile(
          title: Text(orderProduct.product),
          subtitle: Text('R\$ ${orderProduct.price}'),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(orderProduct.quantity.toString()),
            ],
          ),
        );
      },
    );
  }
}
