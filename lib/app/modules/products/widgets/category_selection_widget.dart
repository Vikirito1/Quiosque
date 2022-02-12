import 'package:flutter/material.dart';

import '../../../core/models/category_model.dart';

class CategorySelectionWidget extends StatelessWidget {
  const CategorySelectionWidget({
    Key? key,
    required this.categories,
    required this.onCategorySelected,
    required this.value,
  }) : super(key: key);

  final int? value;
  final List<CategoryModel> categories;
  final void Function(int?)? onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: value,
      items: categories
          .map(
            (category) => DropdownMenuItem(
              child: Text(category.category),
              value: category.id,
            ),
          )
          .toList(),
      onChanged: onCategorySelected,
      hint: const Text('Categoria'),
      validator: (value) {
        if (value == null) {
          return 'O produto precisa de uma categoria';
        } else {
          return null;
        }
      },
    );
  }
}
