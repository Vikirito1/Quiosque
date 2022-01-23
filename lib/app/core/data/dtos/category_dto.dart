import 'package:json_annotation/json_annotation.dart';

part 'category_dto.g.dart';

@JsonSerializable()
class CategoryDTO {
  CategoryDTO({
    this.id,
    this.category,
  });

  final int? id;
  final String? category;

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryDTOToJson(this);
}
