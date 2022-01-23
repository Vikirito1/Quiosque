import 'package:json_annotation/json_annotation.dart';
import 'package:quiosque/app/core/utils/bool_int_converter.dart';

part 'product_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
@BoolIntConverter()
class ProductDTO {
  ProductDTO({
    this.id,
    required this.product,
    required this.price,
    this.shownInMenu = false,
  });

  final int? id;
  final String product;
  final double price;
  final bool shownInMenu;

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
}
