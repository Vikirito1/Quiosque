import 'package:flutter/material.dart';

import 'cancel_button_widget.dart';
import 'confirm_button_widget.dart';

class ConfirmationDialogWidget extends StatelessWidget {
  const ConfirmationDialogWidget({
    Key? key,
    required this.titleText,
    required this.contentText,
    this.onCancelPressed,
    this.onConfirmPressed,
  }) : super(key: key);

  final String titleText;
  final String contentText;
  final void Function()? onCancelPressed;
  final void Function()? onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [
        CancelButtonWidget(
          onPressed: onCancelPressed,
        ),
        ConfirmButtonWidget(
          onPressed: onConfirmPressed,
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceAround,
    );
  }
}
