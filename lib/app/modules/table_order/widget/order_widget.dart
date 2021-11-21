import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/order_model.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({Key? key, required this.activeOrder}) : super(key: key);

  final OrderModel activeOrder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
