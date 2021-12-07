import 'package:flutter/material.dart';

class NoOrderWidget extends StatelessWidget {
  const NoOrderWidget(
      {Key? key, required this.tableNumber, this.onOrderCreated})
      : super(key: key);

  final int tableNumber;
  final void Function()? onOrderCreated;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('Mesa Fechada'),
        TextButton(
          onPressed: onOrderCreated,
          child: Text('Abrir Mesa $tableNumber'),
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.blueAccent,
          ),
        )
      ],
    ));
  }
}
