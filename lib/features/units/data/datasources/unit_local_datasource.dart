import 'package:qrone/core/errors.dart';
import 'package:qrone/features/units/data/models/units_model.dart';
import 'package:qrone/main.dart';
import 'package:qrone/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

abstract class UnitLocalDataSource {
  Future<int> insertTodatabase(UnitModel m);
  Future<List<UnitModel>> getUnitsModels();

  Future<int> updateUnit(UnitModel unitModel);
}

const CASHED_POSTS = "CASHED_POSTS";

class LocaleDataSourceImplem implements UnitLocalDataSource {
  Database db;
  LocaleDataSourceImplem({
    required this.db,
  });

  @override
  Future<int> insertTodatabase(UnitModel unit) async {
    try {
      if (!db.isOpen) {
        db = await getDatabase();
      }

      int id = await db.insert(Dbc.UNITS, unit.toJson(),
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
  Future<List<UnitModel>> getUnitsModels() async {
    if (!db.isOpen) {
      db = await getDatabase();
    }
    try {
      var a = await db.query(Dbc.UNITS);
      var b = a.map((e) => UnitModel.fromJson(e)).toList();
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
  Future<int> updateUnit(UnitModel unitModel) async {
    try {
      if (!db.isOpen) {
        db = await getDatabase();
      }

      int id = await db.delete(
        Dbc.UNITS,
        where: "${Dbc.ID}=?",
        whereArgs: [unitModel.id],
      );
      print(id.toString());
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
