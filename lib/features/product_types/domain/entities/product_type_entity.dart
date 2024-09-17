import 'package:equatable/equatable.dart';

class ProductTypeEntity extends Equatable {
  final int id;
  final String type;
  const ProductTypeEntity({this.id = -1, required this.type});
  ProductTypeEntity copyWith({int? id, String? unit}) {
    return ProductTypeEntity(
      id: id ?? this.id,
      type: unit ?? this.type,
    );
  }

  @override
  List<Object?> get props => [id, type];
}
