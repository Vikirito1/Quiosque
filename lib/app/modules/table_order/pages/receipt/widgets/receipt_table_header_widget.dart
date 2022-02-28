import 'package:flutter/material.dart';

class ReceiptTableHeaderWidget extends StatelessWidget {
  const ReceiptTableHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Text(
            'Qtd',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Text(
            'Descrição',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          flex: 7,
        ),
        Expanded(
          child: Text(
            'Vl. Unit.',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Text(
            'Total',
            textAlign: TextAlign.end,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          flex: 2,
        ),
      ],
    );
  }
}
