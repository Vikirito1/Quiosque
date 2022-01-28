import 'package:flutter/material.dart';
import 'package:quiosque/app/core/utils/utils.dart';

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Utils.showCategoryEditor(context: context),
      icon: const Icon(Icons.add),
    );
  }
}
