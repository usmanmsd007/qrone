import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/utils/constants/database_constants.dart';

class ProductTypeModel extends ProductTypeEntity {
  ProductTypeModel({super.id, required super.type});
  Map<String, dynamic> toJson() {
    return {
      Dbc.PRODUCTTYPE: type,
    };
  }

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['id'] as int,
      type: json[Dbc.PRODUCTTYPE],
    );
  }
}
