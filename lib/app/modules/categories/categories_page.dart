import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/core/utils/utils.dart';
import 'package:quiosque/app/core/widgets/menu_drawer_widget.dart';
import 'package:quiosque/app/modules/categories/categories_controller.dart';

import 'widgets/add_category_widget.dart';
import 'widgets/category_tile_widget.dart';
import 'widgets/exclusion_confirmation_dialog_widget.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  static String route = '/categories';

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late final CategoriesController controller;

  @override
  void initState() {
    controller = GetIt.I<CategoriesController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        actions: [
          Builder(
            // This builder method was added just to "force" the widget below to have a Scaffold as ancestor
            builder: (context) {
              return AddCategoryWidget(
                onPressed: () => Utils.showCategoryEditor(
                  context: context,
                  onSave: controller.onAddSavePressed,
                ),
              );
            },
          ),
        ],
      ),
      drawer: MenuDrawerWidget(routeName: CategoriesPage.route),
      body: Center(
        child: Observer(
          builder: (context) {
            if (controller.categoriesStore.isLoading) {
              return const CircularProgressIndicator();
            } else if (controller.categoriesStore.error != null) {
              return Text(controller.categoriesStore.error!);
            } else {
              return ListView.builder(
                itemCount: controller.categoriesStore.allCategories.length,
                itemBuilder: (_, index) {
                  final CategoryModel category =
                      controller.categoriesStore.allCategories[index];

                  return CategoryTileWidget(
                    category: category,
                    onDelete: (categoryModel) async {
                      final bool? isConfirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) =>
                            const ExclusionConfirmationDialogWidget(),
                      );
                      controller.onDeletePressed(categoryModel, isConfirmed);
                    },
                    onEdit: () => Utils.showCategoryEditor(
                      context: context,
                      category: category,
                      onSave: controller.onEditSavePressed,
                    ),
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
