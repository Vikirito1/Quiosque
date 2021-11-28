import 'package:flutter/material.dart';
import 'package:quiosque/app/core/models/order_model.dart';

class TableWidget extends StatelessWidget {
  const TableWidget({
    Key? key,
    required this.tableNumber,
    this.onTableSelected,
    this.orderModel,
  }) : super(key: key);

  final int tableNumber;
  final Function(int? orderId)? onTableSelected;
  final OrderModel? orderModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTableSelected?.call(orderModel?.id);
      },
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('images/mesa_v.png'),
          ),
          color: orderModel == null ? Colors.redAccent : Colors.greenAccent,
          border: Border.all(width: 3.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: Text(
            '$tableNumber',
            style: const TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
