import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bluetooth_printer_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BluetoothPrinterModel extends Equatable {
  const BluetoothPrinterModel({
    required this.name,
    required this.macAddress,
  });

  final String name;
  final String macAddress;

  @override
  List<Object?> get props => [name, macAddress];

  factory BluetoothPrinterModel.fromJson(Map<String, dynamic> json) =>
      _$BluetoothPrinterModelFromJson(json);

  Map<String, dynamic> toJson() => _$BluetoothPrinterModelToJson(this);
}
