import 'package:flutter/material.dart';
import 'package:quiosque/app/core/widgets/menu_drawer_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  static String route = '/categories';

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      drawer: MenuDrawerWidget(routeName: CategoriesPage.route),
      body: Container(),
    );
  }
}
