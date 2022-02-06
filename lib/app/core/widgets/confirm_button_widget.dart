import 'package:flutter/material.dart';

class ConfirmButtonWidget extends StatelessWidget {
  const ConfirmButtonWidget({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * .3,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text('Confirmar'),
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
        ),
      ),
    );
  }
}
