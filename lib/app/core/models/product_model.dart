import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:quiosque/app/core/utils/bool_int_converter.dart';

part 'product_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@BoolIntConverter()
class ProductModel extends Equatable {
  const ProductModel({
    required this.id,
    required this.product,
    required this.price,
    this.quantity = 1,
    required this.shownInMenu,
  });

  final int id;
  final String product;
  final double price;
  final int? quantity;
  final bool shownInMenu;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  @override
  List<Object?> get props => [id, product, price];
}
