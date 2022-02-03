import 'package:flutter/material.dart';

class AddCategoryWidget extends StatelessWidget {
  const AddCategoryWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
    );
  }
}
