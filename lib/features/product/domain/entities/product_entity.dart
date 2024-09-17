import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final int unitId;
  final int companyId;
  final bool isDeleted;
  final bool isSynced;
  final int productTypeId;
  final double price;
  final String lastUpdated;
  final String companyName;
  final String unitName;
  final String typeName;

  final String name;
  final String code;
  const ProductEntity({
    required this.unitName,
    required this.companyName,
    required this.typeName,
    this.isSynced = false,
    required this.lastUpdated,
    required this.code,
    required this.productTypeId,
    required this.companyId,
    this.id = -1,
    this.isDeleted = false,
    required this.name,
    required this.price,
    required this.unitId,
  });
  ProductEntity copyWith({
    int? id,
    int? unitId,
    int? companyId,
    bool? isDeleted,
    double? price,
    int? productTypeId,
    String? name,
    String? lastUpdated,
    String? code,
    String? companyName,
    String? typeName,
    String? unitName,
    bool? isSynced,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      unitName: unitName ?? this.unitName,
      isSynced: isSynced ?? this.isSynced,
      productTypeId: productTypeId ?? this.productTypeId,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      unitId: unitId ?? this.unitId,
      companyName: companyName ?? this.companyName,
      typeName: typeName ?? this.typeName,
      companyId: companyId ?? this.companyId,
      isDeleted: isDeleted ?? this.isDeleted,
      price: price ?? this.price,
      name: name ?? this.name,
      code: code ?? this.code,
    );
  }

  @override
  List<Object?> get props => [
        isSynced,
        id,
        unitId,
        companyId,
        isDeleted,
        price,
        name,
        code,
        productTypeId
      ];
}
