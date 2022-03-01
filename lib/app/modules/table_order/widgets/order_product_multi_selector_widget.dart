import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/models/category_model.dart';

class OrderProductMultiSelectorWidget extends StatelessWidget {
  const OrderProductMultiSelectorWidget({
    Key? key,
    required this.availableProducts,
    required this.allCategories,
    required this.selectedProducts,
    this.onProductTap,
  }) : super(key: key);

  final List<ProductModel> availableProducts;
  final List<CategoryModel> allCategories;
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
          itemCount: allCategories.length,
          itemBuilder: (_, index) {
            final CategoryModel currentCategory = allCategories[index];
            return Observer(
                builder: (context) => ExpansionTile(
                      title: Text(currentCategory.category),
                      textColor: Theme.of(context).primaryColor,
                      iconColor: Theme.of(context).primaryColor,
                      children: availableProducts
                          .where((product) =>
                              product.category == currentCategory.category)
                          .map((product) => CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (_) => onProductTap?.call(product),
                                value: selectedProducts.contains(product),
                                title: Text(product.product),
                                subtitle: Text(
                                    'R\$ ${product.price.toStringAsFixed(2)}'),
                              ))
                          .toList(),
                    ));
          },
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
