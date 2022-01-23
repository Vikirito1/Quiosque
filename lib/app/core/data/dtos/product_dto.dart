import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductDTO {
  ProductDTO({
    this.id,
    required this.product,
    required this.price,
    required this.categoriesId,
  });

  final int? id;
  final String product;
  final double price;
  final int categoriesId;

  factory ProductDTO.fromJson(Map<String, dynamic> json) =>
      _$ProductDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDTOToJson(this);
}
