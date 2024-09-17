import 'package:qrone/core/errors.dart';
import 'package:qrone/features/product/data/models/product_model.dart';
import 'package:qrone/main.dart';
import 'package:qrone/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

abstract class SyncLocalDataSource {
  Future<List<ProductModel>> getProductModels();
}

class SyncLocalDatasourceImpl extends SyncLocalDataSource {
  Database db;
  SyncLocalDatasourceImpl({required this.db});
  @override
  Future<List<ProductModel>> getProductModels() async {
    if (!db.isOpen) {
      db = await getDatabase();
    }
    try {
      var a = await db
          .query(Dbc.PRODUCT, where: "${Dbc.IS_SYNCED} = ?", whereArgs: [0]);
      // a.forEach((e) => print(e.toString()));
      print(a.toString());
      // var a = await db.query(Dbc.PRODUCT);
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
}
