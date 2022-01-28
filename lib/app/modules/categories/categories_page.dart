import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/core/stores/categories_store.dart';
import 'package:quiosque/app/core/widgets/menu_drawer_widget.dart';

import 'widgets/add_category_widget.dart';
import 'widgets/category_tile_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  static String route = '/categories';

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late final CategoriesStore categoriesStore;

  @override
  void initState() {
    categoriesStore = GetIt.I<CategoriesStore>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        actions: const [
          AddCategoryWidget(),
        ],
      ),
      drawer: MenuDrawerWidget(routeName: CategoriesPage.route),
      body: Center(
        child: Observer(
          builder: (context) {
            if (categoriesStore.isLoading) {
              return const CircularProgressIndicator();
            } else if (categoriesStore.error != null) {
              return Text(categoriesStore.error!);
            } else {
              return ListView.builder(
                itemCount: categoriesStore.allCategories!.length,
                itemBuilder: (_, index) {
                  final CategoryModel category =
                      categoriesStore.allCategories![index];
                  return CategoryTileWidget(
                    category: category,
                    onDelete: () => {},
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
