import 'package:qrone/core/errors.dart';
import 'package:qrone/features/product_types/data/models/product_type_model.dart';
import 'package:qrone/main.dart';
import 'package:qrone/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

abstract class ProductTypeLocalDatasource {
  Future<int> insertTodatabase(ProductTypeModel m);
  Future<List<ProductTypeModel>> getProductTypeModels();
}

class ProductTypeLocalDatasourceImpl implements ProductTypeLocalDatasource {
  Database db;
  ProductTypeLocalDatasourceImpl({
    required this.db,
  });

  @override
  Future<int> insertTodatabase(ProductTypeModel unit) async {
    try {
      if (!db.isOpen) {
        db = await getDatabase();
      }

      int id = await db.insert(Dbc.PRODUCTTYPES, unit.toJson(),
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
  Future<List<ProductTypeModel>> getProductTypeModels() async {
    if (!db.isOpen) {
      db = await getDatabase();
    }
    try {
      var a = await db.query(Dbc.PRODUCTTYPES);
      var b = a.map((e) => ProductTypeModel.fromJson(e)).toList();
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
}
