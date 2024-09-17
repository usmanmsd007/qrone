import 'package:dartz/dartz.dart';
import 'package:qrone/core/errors.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/product_types/data/datasources/product_type_local_datasource.dart';
import 'package:qrone/features/product_types/data/models/product_type_model.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/product_types/domain/repositories/product_type_repository.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class ProductTypeRepositoryImplem implements ProductTypeRepository {
  ProductTypeLocalDatasource localDataSourcel;

  ProductTypeRepositoryImplem({
    required this.localDataSourcel,
  });

  @override
  Future<Either<Failure, List<ProductTypeEntity>>> getProductTypes() async {
    try {
      var productTypes = await localDataSourcel.getProductTypeModels();
      return Right(productTypes);
    } on EmptyListException {
      return Left(EmptyListFailure());
    } on OtherListException {
      return Left(OtherListFailure());
    }
  }

  @override
  Future<Either<Failure, ProductTypeEntity>> addProductType(
      ProductTypeEntity productType) async {
    try {
      var id = await localDataSourcel
          .insertTodatabase(ProductTypeModel(type: productType.type));
      return Right(productType.copyWith(id: id));
    } on InsertException {
      return Left(InsertDataFailure());
    }
  }

  @override
  Future<Either<Failure, ProductTypeEntity>> updateProductType(
      ProductTypeEntity productType) {
    throw UnimplementedError();
  }
}
