import 'package:flutter/material.dart';

import '../../../../../core/utils/constants.dart';

class ReceiptHeaderWidget extends StatelessWidget {
  const ReceiptHeaderWidget({
    Key? key,
    required this.dateAndTime,
    required this.tableNumber,
  }) : super(key: key);

  final String dateAndTime;
  final int tableNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          storeName,
          textAlign: TextAlign.center,
        ),
        const Text(
          storeCnpj,
          textAlign: TextAlign.center,
        ),
        const Text(
          storePhoneNumber,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20.0),
        Text('Data: $dateAndTime'),
        Text('Mesa: $tableNumber'),
      ],
    );
  }
}
