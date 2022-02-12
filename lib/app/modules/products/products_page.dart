import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/core/models/product_model.dart';
import 'package:quiosque/app/core/widgets/menu_drawer_widget.dart';
import 'package:quiosque/app/modules/products/pages/product_management_page.dart';
import 'package:quiosque/app/modules/products/products_controller.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  static String route = '/products';

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final ProductsController controller;
  late final NumberFormat moneyFormat;

  @override
  void initState() {
    controller = GetIt.I<ProductsController>();
    moneyFormat = NumberFormat.simpleCurrency(decimalDigits: 2, name: 'BRL');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produtos'), actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () =>
              Navigator.pushNamed(context, ProductManagementPage.route),
        ),
      ]),
      drawer: MenuDrawerWidget(routeName: ProductsPage.route),
      body: Center(
        child: Observer(
          builder: (context) {
            if (controller.categoriesStore.isLoading) {
              return const CircularProgressIndicator();
            } else if (controller.categoriesStore.error != null) {
              return Text(controller.categoriesStore.error!);
            } else {
              final List<CategoryModel> allCategories =
                  controller.categoriesStore.allCategories;
              final List<ProductModel> allProducts =
                  controller.productsStore.allProducts;

              return ListView.builder(
                itemCount: allCategories.length,
                itemBuilder: (_, index) {
                  final CategoryModel currentCategory = allCategories[index];
                  return ExpansionTile(
                    title: Text(currentCategory.category),
                    textColor: Theme.of(context).primaryColor,
                    iconColor: Theme.of(context).primaryColor,
                    children: allProducts
                        .where(
                          (product) =>
                              product.category == currentCategory.category,
                        )
                        .map(
                          (product) => ListTile(
                            title: Text(product.product),
                            subtitle: Text(product.category),
                            trailing: Text(moneyFormat.format(product.price)),
                            onTap: () => Navigator.pushNamed(
                              context,
                              ProductManagementPage.route,
                              arguments: product,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
