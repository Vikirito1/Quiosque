import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/category_model.dart';

class CategoryTileWidget extends StatelessWidget {
  const CategoryTileWidget({
    Key? key,
    required this.category,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  final CategoryModel category;
  final Function()? onDelete;
  final Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(category.category),
      leading: IconButton(
        icon: const Icon(Icons.edit),
        color: Theme.of(context).primaryColor,
        onPressed: onEdit,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        color: Theme.of(context).primaryColor,
        onPressed: onDelete,
      ),
    );
  }
}
