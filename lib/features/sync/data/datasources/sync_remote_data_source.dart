import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qrone/core/errors.dart';
import 'package:qrone/features/companies/data/models/company_model.dart';
import 'package:qrone/features/product/data/models/product_model.dart';
import 'package:qrone/features/product_types/data/models/product_type_model.dart';
import 'package:qrone/features/units/data/models/units_model.dart';
import 'package:qrone/utils/constants/database_constants.dart';

abstract class SyncRemoteDataSource {
  Future<bool> uploadUnits(List<UnitModel> units);
  Future<bool> uploadCompanies(List<CompanyModel> companies);
  Future<bool> uploadTypes(List<ProductTypeModel> types);
  Future<bool> uploadProducts(List<ProductModel> products);
}

class SyncRemoteDataSourceImpl extends SyncRemoteDataSource {
  FirebaseFirestore firebaseFirestore;
  SyncRemoteDataSourceImpl({required this.firebaseFirestore});
  @override
  Future<bool> uploadCompanies(List<CompanyModel> companies) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (CompanyModel company in companies) {
        DocumentReference docRef = FirebaseFirestore.instance
            .collection(Dbc.COMPANIES)
            .doc(company.id.toString());
        batch.set(docRef, company.toJson());
      }
      await batch.commit();
      return true;
    } catch (e) {
      throw DataNotUploadedException();
    }
  }

  @override
  Future<bool> uploadProducts(List<ProductModel> products) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (ProductModel product in products) {
        DocumentReference docRef = FirebaseFirestore.instance
            .collection(Dbc.PRODUCT)
            .doc(product.id.toString());
        batch.set(docRef, product.toJson());
      }
      await batch.commit();
      return true;
    } catch (e) {
      throw DataNotUploadedException();
    }
  }

  @override
  Future<bool> uploadTypes(List<ProductTypeModel> types) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (ProductTypeModel type in types) {
        DocumentReference docRef = FirebaseFirestore.instance
            .collection(Dbc.PRODUCTTYPE)
            .doc(type.id.toString());
        batch.set(docRef, type.toJson());
      }
      await batch.commit();
      return true;
    } catch (e) {
      throw DataNotUploadedException();
    }
  }

  @override
  Future<bool> uploadUnits(List<UnitModel> units) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      for (UnitModel unit in units) {
        DocumentReference docRef = FirebaseFirestore.instance
            .collection(Dbc.UNITS)
            .doc(unit.id.toString());
        batch.set(docRef, unit.toJson());
      }
      await batch.commit();
      return true;
    } catch (e) {
      throw DataNotUploadedException();
    }
  }
}
