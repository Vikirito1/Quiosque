import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/core/utils/utils.dart';

class CategoryTileWidget extends StatelessWidget {
  const CategoryTileWidget({
    Key? key,
    required this.category,
    this.onDelete,
    this.onSave,
  }) : super(key: key);

  final CategoryModel category;
  final Function()? onDelete;
  final Function()? onSave;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.category),
      leading: IconButton(
        icon: const Icon(Icons.edit),
        color: Theme.of(context).primaryColor,
        onPressed: () => Utils.showCategoryEditor(
          context: context,
          category: category,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        color: Theme.of(context).primaryColor,
        onPressed: onDelete,
      ),
    );
  }
}
