import 'package:flutter/material.dart';

class ReceiptAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ReceiptAppBarWidget({
    Key? key,
    required this.title,
    this.onPrintPressed,
  }) : super(key: key);

  final String title;
  final void Function()? onPrintPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onPrintPressed,
          icon: const Icon(Icons.print),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}
