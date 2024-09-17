import 'package:qrone/core/errors.dart';
import 'package:qrone/features/product/data/models/product_model.dart';
import 'package:qrone/main.dart';
import 'package:qrone/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductLocalDataSource {
  Future<int> insertProcutTodatabase(ProductModel m);
  Future<List<ProductModel>> getProductModels();
  Future<List<ProductModel>> searchProductModels(String code);
  Future<int> updateProduct(ProductModel p);
}

class ProductLocalDataSourceImpl extends ProductLocalDataSource {
  Database db;
  ProductLocalDataSourceImpl({required this.db});
  @override
  Future<List<ProductModel>> getProductModels() async {
    if (!db.isOpen) {
      db = await getDatabase();
    }
    try {
      var a = await db.rawQuery('''
SELECT * FROM ${Dbc.PRODUCT}
  INNER JOIN ${Dbc.COMPANIES} ON ${Dbc.COMPANIES}.${Dbc.ID} = ${Dbc.PRODUCT}.${Dbc.P_COMPANY_ID}
  INNER JOIN ${Dbc.UNITS} ON ${Dbc.UNITS}.${Dbc.ID} = ${Dbc.PRODUCT}.${Dbc.P_UNIT_ID}
  INNER JOIN ${Dbc.PRODUCTTYPES} ON ${Dbc.PRODUCTTYPES}.${Dbc.ID} = ${Dbc.PRODUCT}.${Dbc.PRODUCT_TYPE_ID}
''');
      print(a.toString());
      var b = a.map((e) => ProductModel.fromJson(e)).toList();
      if (b.isEmpty) {
        print("list is empty");
        throw EmptyListException();
      } else {
        return b;
      }
    } on EmptyListException {
      throw EmptyListException();
    } catch (e) {
      print(e.toString());
      throw OtherListException();
    } finally {
      await db.close();
    }
  }

  @override
  Future<int> insertProcutTodatabase(ProductModel m) async {
    try {
      if (!db.isOpen) {
        db = await getDatabase();
      }

      int id = await db.insert(Dbc.PRODUCT, m.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      print(id.toString());
      if (id == 0) {
        throw InsertException(message: "Error during insertion");
      } else {
        return id;
      }
    } catch (e) {
      throw InsertException(message: e.toString());
    } finally {
      await db.close();
    }
  }

  @override
  Future<List<ProductModel>> searchProductModels(String code) async {
    if (!db.isOpen) {
      db = await getDatabase();
    }
    try {
      var a = await db.rawQuery('''
SELECT * FROM ${Dbc.PRODUCT} 
  INNER JOIN ${Dbc.COMPANIES} ON ${Dbc.COMPANIES}.${Dbc.ID} = ${Dbc.PRODUCT}.${Dbc.P_COMPANY_ID}
  INNER JOIN ${Dbc.UNITS} ON ${Dbc.UNITS}.${Dbc.ID} = ${Dbc.PRODUCT}.${Dbc.P_UNIT_ID}
  INNER JOIN ${Dbc.PRODUCTTYPES} ON ${Dbc.PRODUCTTYPES}.${Dbc.ID} = ${Dbc.PRODUCT}.${Dbc.PRODUCT_TYPE_ID}
  WHERE ${Dbc.PRODUCT}.${Dbc.P_CODE}=$code AND ${Dbc.PRODUCT}.${Dbc.P_ISDELETED_ID}=0
''');
      var b = a.map((e) => ProductModel.fromJson(e)).toList();
      if (b.isEmpty) {
        print("list is empty");
        throw EmptyListException();
      } else {
        return b;
      }
    } on EmptyListException {
      throw EmptyListException();
    } catch (e) {
      print(e.toString());
      throw OtherListException();
    } finally {
      await db.close();
    }
  }

  @override
  Future<int> updateProduct(
    ProductModel p,
  ) async {
    try {
      if (!db.isOpen) {
        db = await getDatabase();
      }

      int id = await db.update(Dbc.PRODUCT, p.toJson(),
          where: "${Dbc.ID}=?",
          whereArgs: [p.id],
          conflictAlgorithm: ConflictAlgorithm.replace);

      if (id == 0) {
        throw UpdateException(message: "Error during insertion");
      } else {
        return id;
      }
    } catch (e) {
      throw UpdateException(message: e.toString());
    } finally {
      await db.close();
    }
  }
}
