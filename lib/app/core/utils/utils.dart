import 'package:flutter/material.dart';
import 'package:quiosque/app/core/data/dtos/category_dto.dart';
import 'package:quiosque/app/core/models/category_model.dart';
import 'package:quiosque/app/modules/categories/widgets/edit_category_widget.dart';

class Utils {
  static void showCategoryEditor({
    required BuildContext context,
    CategoryModel? category,
    void Function(CategoryDTO value)? onSave,
  }) {
    showBottomSheet(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.9,
      ),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      context: context,
      builder: (context) => EditCategoryWidget(
        onCancel: () => Navigator.pop(context),
        onSave: onSave,
        category: category,
      ),
    );
  }
}
