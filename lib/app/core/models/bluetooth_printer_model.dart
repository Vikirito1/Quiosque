import 'package:equatable/equatable.dart';

class BluetoothPrinterModel extends Equatable {
  const BluetoothPrinterModel({
    required this.name,
    required this.macAddress,
  });

  final String name;
  final String macAddress;

  @override
  List<Object?> get props => [name, macAddress];
}
