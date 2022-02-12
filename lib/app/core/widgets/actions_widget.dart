import 'package:flutter/material.dart';

import 'cancel_button_widget.dart';
import 'confirm_button_widget.dart';

class ActionsWidget extends StatelessWidget {
  const ActionsWidget({
    Key? key,
    this.onCancelPressed,
    this.onConfirmPressed,
  }) : super(key: key);

  final void Function()? onCancelPressed;
  final void Function()? onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CancelButtonWidget(onPressed: onCancelPressed),
        ConfirmButtonWidget(onPressed: onConfirmPressed),
      ],
    );
  }
}
