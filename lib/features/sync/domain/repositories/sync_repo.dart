import 'package:dartz/dartz.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';

abstract class SyncRepo {
  Future<Either<Failure, List<ProductEntity>>> getUnSyncedProducts();
  Future<Either<Failure, bool>> uploadProducts(
      {required List<ProductEntity> products});

  Future<Either<Failure, bool>> uploadTypes(
      {required List<ProductTypeEntity> type});

  Future<Either<Failure, bool>> uploadCompanies(
      {required List<CompanyEntity> companyEntity});

  Future<Either<Failure, bool>> uploadUnits({required List<Units> units});
}
