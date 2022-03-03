import 'package:flutter/material.dart';
import 'package:quiosque/app/core/widgets/menu_drawer_tile_widget.dart';
import 'package:quiosque/app/modules/categories/categories_page.dart';
import 'package:quiosque/app/modules/home/home_page.dart';
import 'package:quiosque/app/modules/printer_setup/printer_setup_page.dart';
import 'package:quiosque/app/modules/products/products_page.dart';

import 'menu_drawer_header_widget.dart';

class MenuDrawerWidget extends StatelessWidget {
  const MenuDrawerWidget({Key? key, required this.routeName}) : super(key: key);

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MenuDrawerHeaderWidget(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                MenuDrawerTileWidget(
                  title: 'Mesas',
                  leading: Image.asset(
                    'images/mesa_o.png',
                    width: 24.0,
                    height: 24.0,
                    color: routeName == HomePage.route
                        ? Colors.white
                        : Colors.grey,
                  ),
                  selected: routeName == HomePage.route,
                  routeName: HomePage.route,
                ),
                MenuDrawerTileWidget(
                  title: 'Produtos',
                  leading: const Icon(Icons.format_list_bulleted_rounded),
                  selected: routeName == ProductsPage.route,
                  routeName: ProductsPage.route,
                ),
                MenuDrawerTileWidget(
                  title: 'Categorias',
                  leading: const Icon(Icons.style_outlined),
                  selected: routeName == CategoriesPage.route,
                  routeName: CategoriesPage.route,
                ),
                MenuDrawerTileWidget(
                  title: 'Impressão',
                  leading: const Icon(Icons.print),
                  selected: routeName == PrinterSetupPage.route,
                  routeName: PrinterSetupPage.route,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
