import 'package:qrone/core/errors.dart';
import 'package:qrone/features/companies/data/models/company_model.dart';
import 'package:qrone/main.dart';
import 'package:qrone/utils/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

abstract class CompanyLocalDataSource {
  Future<int> insertTodatabase(CompanyModel m);
  Future<List<CompanyModel>> getCompanysModels();
}

const CASHED_POSTS = "CASHED_POSTS";

class CompanyLocaleDataSourceImplem implements CompanyLocalDataSource {
  Database db;
  CompanyLocaleDataSourceImplem({
    required this.db,
  });

  @override
  Future<int> insertTodatabase(CompanyModel company) async {
    try {
      if (!db.isOpen) {
        db = await getDatabase();
      }

      int id = await db.insert(Dbc.COMPANIES, company.toJson(),
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
  Future<List<CompanyModel>> getCompanysModels() async {
    if (!db.isOpen) {
      db = await getDatabase();
    }
    try {
      var a = await db.query(Dbc.COMPANIES);
      var b = a.map((e) => CompanyModel.fromJson(e)).toList();
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
