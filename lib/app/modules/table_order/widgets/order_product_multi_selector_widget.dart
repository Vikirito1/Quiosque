import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quiosque/app/core/models/product_model.dart';

class OrderProductMultiSelectorWidget extends StatelessWidget {
  const OrderProductMultiSelectorWidget({
    Key? key,
    required this.availableProducts,
    required this.selectedProducts,
    this.onProductTap,
  }) : super(key: key);

  final List<ProductModel> availableProducts;
  final List<ProductModel> selectedProducts;
  final Function(ProductModel product)? onProductTap;
  // final OrderProductsStore _store = GetIt.I<OrderProductsStore>();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return AlertDialog(
      title: const Text('Selecione os itens'),
      content: SizedBox(
        width: screenSize.width,
        height: screenSize.height * .8,
        child: ListView.builder(
          itemCount: availableProducts.length,
          itemBuilder: (_, index) => Observer(
            builder: (_) => CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (_) => onProductTap?.call(availableProducts[index]),
              value: selectedProducts.contains(availableProducts[index]),
              title: Text(availableProducts[index].product),
              subtitle: Text(
                  'R\$ ${availableProducts[index].price.toStringAsFixed(2)}'),
            ),
          ),
        ),
      ),
      actions: [
        SizedBox(
          width: screenSize.width * .8,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ),
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
