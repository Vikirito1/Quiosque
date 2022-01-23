import 'package:flutter/material.dart';
import 'package:quiosque/app/core/widgets/menu_drawer_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  static String route = '/products';

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      drawer: MenuDrawerWidget(routeName: ProductsPage.route),
      body: Container(),
    );
  }
}
