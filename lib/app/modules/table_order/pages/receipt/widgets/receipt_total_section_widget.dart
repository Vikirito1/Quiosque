import 'package:flutter/material.dart';

class ReceiptTotalSectionWidget extends StatelessWidget {
  const ReceiptTotalSectionWidget({
    Key? key,
    required this.total,
  }) : super(key: key);

  final String total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'VALOR TOTAL',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            total,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
