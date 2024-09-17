import 'package:dartz/dartz.dart';
import 'package:qrone/core/errors.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/core/network/network_file.dart';
import 'package:qrone/features/companies/data/models/company_model.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/product/data/models/product_model.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product_types/data/models/product_type_model.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/sync/data/datasources/sync_local_datasource.dart';
import 'package:qrone/features/sync/data/datasources/sync_remote_data_source.dart';
import 'package:qrone/features/sync/domain/repositories/sync_repo.dart';
import 'package:qrone/features/units/data/models/units_model.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';

class SyncRepoImpl extends SyncRepo {
  SyncRemoteDataSource syncRemoteDataSource;
  SyncLocalDataSource syncLocalDataSource;
  NetworkInfo networkInfo;
  SyncRepoImpl(
      {required this.networkInfo,
      required this.syncLocalDataSource,
      required this.syncRemoteDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getUnSyncedProducts() async {
    try {
      var products = await syncLocalDataSource.getProductModels();
      return Right(products);
    } on EmptyListException {
      return Left(EmptyListFailure());
    } on OtherListException {
      return Left(OtherListFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> uploadCompanies(
      {required List<CompanyEntity> companyEntity}) async {
    if (await networkInfo.isConnected) {
      try {
        var a = await syncRemoteDataSource.uploadCompanies(companyEntity
            .map((c) => CompanyModel(companyName: c.companyName, id: c.id))
            .toList());
        return Right(a);
      } on DataNotUploadedException {
        return Left(DataNotUploadedFailure());
      } catch (e) {
        return Left(DataNotUploadedFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> uploadProducts(
      {required List<ProductEntity> products}) async {
    if (await networkInfo.isConnected) {
      try {
        var a = await syncRemoteDataSource.uploadProducts(products
            .map(
              (c) => ProductModel(
                code: c.code,
                companyId: c.companyId,
                unitId: c.unitId,
                productTypeId: c.productTypeId,
                name: c.name,
                lastUpdated: c.lastUpdated,
                id: c.id,
                isSynced: c.isSynced,
                price: c.price,
                companyName: c.companyName,
                typeName: c.typeName,
                unitName: c.unitName,
              ),
            )
            .toList());
        return Right(a);
      } on DataNotUploadedException {
        return Left(DataNotUploadedFailure());
      } catch (e) {
        return Left(DataNotUploadedFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> uploadTypes(
      {required List<ProductTypeEntity> type}) async {
    if (await networkInfo.isConnected) {
      try {
        var a = await syncRemoteDataSource.uploadTypes(
            type.map((c) => ProductTypeModel(type: c.type, id: c.id)).toList());
        return Right(a);
      } on DataNotUploadedException {
        return Left(DataNotUploadedFailure());
      } catch (e) {
        return Left(DataNotUploadedFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> uploadUnits(
      {required List<Units> units}) async {
    if (await networkInfo.isConnected) {
      try {
        var a = await syncRemoteDataSource.uploadUnits(
            units.map((c) => UnitModel(unit: c.unit, id: c.id)).toList());
        return Right(a);
      } on DataNotUploadedException {
        return Left(DataNotUploadedFailure());
      } catch (e) {
        return Left(DataNotUploadedFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}
