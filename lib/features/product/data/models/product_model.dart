import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/utils/constants/database_constants.dart';

class ProductModel extends ProductEntity {
  ProductModel(
      {required super.code,
      required super.companyId,
      required super.id,
      required super.isSynced,
      required super.name,
      required super.price,
      required super.unitId,
      required super.companyName,
      required super.typeName,
      required super.unitName,
      required super.lastUpdated,
      required super.productTypeId,
      super.isDeleted});

  Map<String, dynamic> toJson() {
    return {
      Dbc.PRODUCT_TYPE_ID: productTypeId,
      Dbc.ID: id == -1 ? null : id,
      Dbc.P_LASTUPDATED: lastUpdated,
      Dbc.P_UNIT_ID: unitId,
      Dbc.P_COMPANY_ID: companyId,
      Dbc.P_ISDELETED_ID: isDeleted ? 1 : 0,
      Dbc.IS_SYNCED: isDeleted ? 1 : 0,
      Dbc.P_PRICE: price,
      Dbc.P_NAME: name,
      Dbc.P_CODE: code,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return ProductModel(
      companyName: json[Dbc.COMPANYNAME],
      unitName: json[Dbc.UNIT_NAME],
      typeName: json[Dbc.PRODUCTTYPE],
      productTypeId: json[Dbc.PRODUCT_TYPE_ID],
      lastUpdated: json[Dbc.P_LASTUPDATED],
      id: json[Dbc.ID],
      unitId: json[Dbc.P_UNIT_ID],
      companyId: json[Dbc.P_COMPANY_ID],
      isDeleted: json[Dbc.P_ISDELETED_ID] == 1 ? true : false,
      isSynced: json[Dbc.IS_SYNCED] == 1 ? true : false,
      price: json[Dbc.P_PRICE],
      name: json[Dbc.P_NAME] ?? "",
      code: json[Dbc.P_CODE] ?? "",
    );
  }
}
