import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/product_model.dart';

import '../../../core/models/category_model.dart';
import 'order_product_multi_selector_widget.dart';

class AddOrderProductWidget extends StatelessWidget {
  const AddOrderProductWidget({
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

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) => OrderProductMultiSelectorWidget(
            availableProducts: availableProducts,
            allCategories: allCategories,
            selectedProducts: selectedProducts,
            onProductTap: onProductTap,
          ),
        );
      },
      icon: const Icon(Icons.add),
    );
  }
}
